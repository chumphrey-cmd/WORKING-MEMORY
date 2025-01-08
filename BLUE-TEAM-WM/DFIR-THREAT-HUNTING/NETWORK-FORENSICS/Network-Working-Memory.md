# Network Forensics

## Web Proxy Data

### Common Log Fields
- UNIX Timestamp
- Response Time
- Requestor IP (Layer 3 or X Forwarded For)
- Cache Status & HTTP Status Code (Cache or Retrieved)
- Reply Size (Bytes)
- Request Method (GET, POST, etc.)
- URL Requested
- Username (If proxy authentication used)
- MIME Type (Given by the Originating Server)



### Convert Timestamps
```date -d @1573137112.368```



To UTC  
```date -u -d @1573137112.368```



Convert a lot of timestamps at once
```
sudo cat /var/log/squid/access.log |
awk '{$1=strftime("%F %T", $1, 1);
print $0}'
```



### Threat Hunt Process
- Plan
- Collect Evidence
- Form Hypothesis (Likely a broad one)
- Analyze Evidence
- Support/refute/refine hypothesis
  - Repeat until stable



### Uniq Domain Counts
```
grep-v "\"CONNECT " access.log |
awk '{ print $7 }' |
awk -f/ '{ print $3 }' |
sort | uniq -c | sort -nr
```



### Google Auto Complete
```
grep google.com access.log | wc -l

grep google.com access.log | grep complete | wc -l

grep google.com access.log | grep complete | less
```



## HTTPS

### Request Componenets

- OPTIONS: Allows the client to query the server for requirements or capabilities
- HEAD: Identical to GET, but tells server to only return resulting headers for the request
- PUT: Requests that the serer create a resource at the specified location, containing the data supplied in the request
- DELETE: Requests that the server remove a resource at the specified location
- TRACE: Used in troubleshooting a request across multiple proxy srevers -- this is not common and is generally disabled on servers
- CONNECT: Requests that a proxy switch to a tunnel, such as with SSL/TLS encryption



Notes:
- Other specialized protocols such as WebDAV user their own methods as well
- X-Forwarded-For: a header that indicates the original source of the rquest in the event that multiple proxy servers handled the request



### Response Codes
- **100, Continue**: After the serer recieves the headers for a request, this directs the client to proceed
- **200, OK**: Possibly the most common value, indicates the server was able to fufill the request with errors
- **301, Moved Permanently**: The server provides a new URL for the request resource and the client then ostensibly makes that request. "Permanent" means the original request should assumed outdated.
- **302, Found**: In practice, a temporary relocation, althouhg this is not strictly in compliance with the standard
- **304, Not Modified**: Indicates the request resource has not changed since it was last requested
- **400, Bad Syntax**: The request was somehow syntactically incorrect
- **401, Unauthorized**: Client mus authenticate before the response can be given
- **403, Forbidden**: Request was valid, but client is not permitted access (regardless of authentication)
- **404, Not Found**: Requested resource does not exist
- **407, Proxy Authentication Required**: Like 401, but for the proxy server
- **500, Internal Server Error**: Generic Server Error Message.
- **503, Service Unavailable**:, Server is overloaded or undergoing maintenance.
- **507, Network Authentication Required**: Client must authenticate to gain access-used by captive proxies such as at Wi-Fi hotspots.



Notes
- A long bout of 400-series return codes from a single IP address may suggest recon
- A sequence of 500-series return codes against a search form followed by a 200 response and a lot of HTTP POST requests could be SQL injection attempt and success, followed by post-compromise operations



### Response Components
- Server contiues using current TCP session
  - ```Connection: Keep-Alive```
- Server stops using  currect TCP session
  - ```Connection: Close```
- Server inidcates its software using ```Server``` field
  - ```Server: Apache/2```
  - ```Server: Cloudflare-nginx```
  - ```Server: Microsoft-IIS/8.0```
- Server returns the size, data type, encoding information, as well as the application that should be used to render the response in the ```Content-*``` header
  - ```Content-Length: 17962```
  - ```Content-Type: text/html; charset=utf-8```
  - ```Content-Encoding: gzip```



### Useful Fields
- Data Extracted from Compromised Systems (POST)
- User-Agent String can build Activity Profiles
  - Malware may user User-Agent to indicate version
- Basic Auth is easily reversed
  - Authorization: Basic 
- URIs show a subjects activity
  - Requested URL, Referer, Location (Redirect)



**Google Analytics Cookies**
- track visitors source, path, and history
- Include very useful timestamps and counters
- Long-living: 2yr, 30 min, 6 mo rolling retention periods



### HTTP2
- Sent via TLS
- Compressed headers and tags
- Fully multiplexed
  - Multiple requests per message
  - Parts of multiple responses per message
- Servers can force "push" objects to browsers
  - No browser indication that object was not requested



**SIFT - Proxy Logs**  
- Display the time, request method, hostname, requested URI, and User-Agent string from the contents of a pcap file  
  - ```tshark -n -C no_desegment_tcp -r example.pcap -T fields -e frame.time -e http.request.method -e http.host -e http.request.uri -e http.user_agent -Y 'http.request' > /path/to/output/useragent_derived.log```
- Determine frequency each unique User-Agent String appears within log file
  - ```cat useragent_derived.log | awk -F"\t" '{print $5}' | sort | uniq -c | sort -nr```
- Determine what HTTP request methods and host values are associated with the User-Agent strings
  - ```grep "<%USER-AGENT_SUBSTRING%>" useragent_derived.log |  awk -F"\t" '{print $2,$3}' | sort | uniq -c | sort -nr```
  - ```grep "<%USER-AGENT_SUBSTRING%>" useragent_derived.log |  awk -F"\t" '{print $4}' | sort | uniq -c | sort -nr```
  - ```grep "Firefox/15.0" useragent_derived.log | awk -F"\t" '{print $2,$3}' | sort | uniq -c | sort -nr```
  - ```grep "Firefox/15.0" useragent_derived.log | awk -F"\t" '{print $4}' | sort | uniq -c | sort -nr```
  - ```grep "MSIE 8.0" useragent_derived.log | awk -F"\t" '{print $2,$3}' | sort | uniq -c | sort -nr```
  - ```grep "MSIE 8.0" useragent_derived.log | awk -F"\t" '{print $4}' | sort | uniq -c | sort -nr```
- Breakdown PCAPs contents by protocol
  - ```tshark -n -C no_desegment_tcp -r example.pcap -q -z io,phs```
- Determine First and Last Seen Times for User Agent
 - ```tshark -n -C no_desegment_tcp -r example.pcap -T fields -e frame.time -Y 'http.user_agent contains "Firefox/15.0"' | head -n 1```
 - ```tshark -n -C no_desegment_tcp -r example.pcap -T fields -e frame.time -Y 'http.user_agent contains "Firefox/15.0"' | tail -n 1```
 - ```tshark -n -C no_desegment_tcp -r example.pcap -T fields -e frame.time -Y 'http.user_agent contains "MSIE 8.0"' | head -n 1```
 - ```tshark -n -C no_desegment_tcp -r example.pcap -T fields -e frame.time -Y 'http.user_agent contains "MSIE 8.0"' | tail -n 1```
- Determine time between key presses within each search
 - ```tshark -n -C no_desegment_tcp -r 10_3_59_127.pcap -T fields -e frame.time_delta_displayed -e frame.time -e http.request.uri -Y 'http.user_agent contains "MSIE 8.0" and http.request.uri contains "sugexp"'```

 

### HTTP Log Formats
- Apache
  - NCSA Common, NCSA Common+VHost, W3C Extended/Combined
  - Optional seperate Referer, User-Agent logs
  - Customizable with format strings
  - Selective use of "mod forensic" request logging
- IIS NCSA
  - NCSA Common, W3C Extended, IIS
  - Central Binary Logging, ODBC database
  - Customizable with field names



### NCSA Common Format
- Requesting Hostname/IP
- Requesting username (usually"-")
- Authenticated user
- Time request received
- Request Method, URI, including query string, and protocol
- Status code of last request (incl. redirects)
- Size of requested object (excl. headers)



### W3C Extended/Combined Format
- Same NCSA Common Fields
- HTTP Referer header string
  - Can help characterize suspicious traffic
- HTTP User-Agent header string
  - May identify malicious utilities or forged traffic



### IIS Log File Format
- Requesting IP
- Authenticated User
- Date & Time
- Instance Name, server name, server IP
- Milliseconds to serve
- Bytes in request
- Bystes sent in response
- HTTP status code
- Windows return code
- HTTP request method
- Requested resource
- HTTP GET request parameters



### IIS Centralized Binary Logging ODBC
- Highly efficient formats for large/busy servers
- CBL sotres in local file, ODBC uses SQL Server
- Require querying and parsing to get human readable data
- Microsoft Log Parser is excellent tool for this



### HTTP Log File Analysis Methods
- Microsoft Log Parser provides SQL-like powering text and binary files of all kinds
- SOF-ELK natively handles NCSA and W3C HTTP formats
- Database backend natively handles SQL Ginsu



### Investigative Value of HTTP Logs
- Identify probing for vulnerable websites
- Identify SQL injection attempts/successes
- Determine a known-bad IP accessed
- Find Remote Admin Tools (RATs) in use
- Track attackers actions using RAT
  - Reconstruct uploaded malware



## DNS

### DNS Basics
- PTR: Reverse IP lookup
  - 172.16.5.14 lookup becomes 14.5.16.172.in-addr.arpa PTR query
- NXDOMAIN indicates nonexistent domain or hostname
- Stateless: uses transaction ID field



### DNS in Network Forensics and Incident Response
- Should not be fully outsourced to 8.8.8.8
- Clients should use internal resolvers
  - Internal resolvers forward requests outside
  - Block clients from direct external DNS access



### Fast Flux DNS Single
- Rapidly changing IP addresses to thwart blocking
  - Typically, low TTLs; many A records per response



### Fast Flux Double
- Similar to "single"
- Also uses compromised hosts for the NS record it returns
- First tier of compromised hosts act as DNS proxies
- Still contain low TTL, A records



### Detecting Fast Flux DNS
- DNS Response TTL less than 300
- DNS Answers greater than 12
- Recently Registered Domains



## Domain Generation Algorithms
- Uses seed value (usually date) for algorithm to create many possible C2 domains
- Identify via heuristics, historical norms, threat intel
  - Large amount of NXDOMAIN responses



### DNS over Everything
- DNS over TLS (Dot), DNS over HTTPs (DOH)
- DoH
  - HTTPs traffic to name servers



### Punycode
- A puny-encoded hostname starts with "xn--" followed by asci chararcters in the hostnname, then another "-"



## Network Security Monitoring
- Zeek
  - community-id.py
    - Hashes source+dest IP addresses+ports, Layer 4 protocol
    - SHA1 hash of non-directional flow event



### SIFT - DNS Logs
- Determine how large the dataset is
  - ```zcat 2019-12-*/dns.*.gz | wc -l```
- Determine timeframe
  - ```zcat 2019-12-09/dns.17\:00\:00-18\:00\:00.log.gz | head -n 1 | jq -cr '.ts |= todate | .ts'```
  - ```zcat 2019-12-10/dns.14\:00\:00-15\:00\:00.log.gz | tail -n 1 | jq -cr '.ts |= todate | .ts'```
- Examine the first record from any of the DNS log
  - ```zcat 2019-12-09/dns.21\:00\:00-22\:00\:00.log.gz | head -n 1 | jq '.'```



### Baseline DNS Data
- Distrobution of Response Codes
  - ```zcat 2019-12-*/dns.*.gz | jq -r '.rcode_name' | sort | uniq -c | sort -nr | head -n 20```
    - NOERROR: Normal Response
    - NXDOMAIN: A hostname on a nonexistent domain was requested
    - SERVFAIL: A error occured on the server's end
    - null: ANot a response code, but indicates no rcode_name field was present
- Profile the query types that generated a successful response code
  - ```zcat 2019-12-*/dns.*.gz | jq -r 'select(.rcode_name == "NOERROR") | .qtype_name' | sort | uniq -c | sort -nr```
- Distrobution of query types that did not return successfully
  - ```zcat 2019-12-*/dns.*.gz | jq -r 'select(.rcode_name != "NOERROR") | .qtype_name' | sort | uniq -c | sort -nr```
- For each query type, what were the response codes
  - ```zcat 2019-12-*/dns.*.gz | jq -cr 'select(.rcode_name != "NOERROR") | { qtype_name, rcode_name }'  | sort | uniq -c | sort -nr

- Top 20 queried hostnames
  - ```zcat 2019-12-*/dns.*.gz | jq -r 'select(.rcode_name == "NOERROR") | .query' | sort | uniq -c | sort -nr | head -n 20```
- Top 20 queried hostnames that did not return successfully
  - ```zcat 2019-12-*/dns.*.gz | jq -r 'select(.rcode_name != "NOERROR") | .query' | sort | uniq -c | sort -nr | head -n 20```



Notes:
- High Number of NXDOMAIN
- Filter out PTR Records for further analysis
- Compare list of top queried hostnames to previoud periods
  - Identify hostnames that became popular for a short period of time
- SERVFAIL responses could be of interest



### Identify Malicious/Suspicious NXDOMAIN Activty using DNS Logs
- Examine the full set of DNS queries that resulted in an NXDOMAIN response
  - ```zcat 2019-12-*/dns.*.gz | jq -r 'select(.rcode_name == "NXDOMAIN") | .query' | sort | uniq -c | sort -nr```
- What host exibited activity?
  - ```zcat 2019-12-*/dns.*.gz | jq -r 'select(.query == "dinnernotice.net") | ."id.orig_h"' | sort | uniq -c | sort -nr```
- Calculate time in between events



### Identify Malicious/Suspicious DNS Activity Using Threat Intelligence
- Hostnames associated with IP address
  - ```zgrep -h 209.160.65.66 2019-12-*/dns.*.gz | jq -cr '.query'```
- See hosts associated with hostname
  - ```zcat 2019-12-*/dns.*.gz | jq -cr 'select(.query == "api.roherewharewha.com") | ."id.orig_h"' | sort | uniq -c | sort -nr```
-  Observed Time Frame
  - ```zgrep -h api.roherewharewha.com 2019-12-*/dns.*.gz | jq -cr 'select(."id.orig_h" == "172.16.4.4") | .ts |= todate | { ts, "id.orig_h" }' | head -n 1```
  - ```zgrep -h api.roherewharewha.com 2019-12-*/dns.*.gz | jq -cr 'select(."id.orig_h" == "172.16.4.4") | .ts |= todate | { ts, "id.orig_h" }' | tail -n 1```



## Netflow

- HTTP/80
  - Client Volume: Small
  - Server Volume: Large
  - Connection Duration: Short
  - Potential Activity: Typical HTTP Download
- HTTPS/443
  - Client Volume: Large
  - Server Volume: Small
  - Connection Duration: Various
  - Potential Activity: HTTP POST Upload
- HTTPS/443
  - Client Volume: Large
  - Server Volume: Large
  - Connection Duration: Long
  - Potential Activity: TLS VPN
- SSH/22
  - Client Volume: Small
  - Server Volume: Large
  - Connection Duration: Various
  - Potential Activity: SCP Download
- HTTP/22
  - Client Volume: Various
  - Server Volume: Various
  - Connection Duration: Long
  - Potential Activity: Command Shell
- DNS/53
  - Client Volume: Large
  - Server Volume: Large
  - Connection Duration: Long
  - Potential Activity: Tunnel? Suspicious



### Open Source Tools
 - nfcapd
  - Recieve netflow data (v5, v7, v9, IPFIX, SFLOW)
  - parsed with nfdump



## FTP

### Capturing FTP
- port 20 or 21
- src portrange 1024-65535 or src port 20
- dst portrange 1024-65535 or dst port 20



### Tracking Lateral Movement with NetFlow
- Identify the top five external source IP addresses overall and the top five internal source IP addresses from Client Subnets
  - ```nfdump -R 2018/ -s srcip/bytes -n 5 'not src net 172.16.0.0/16'```
  - ```nfdump -R 2018/ -s srcip/bytes -n 5 'src net 172.16.6.0/24 or src net 172.16.7.0/24'```
- Perform a more in-depth review of the IP addresses associated with the anomalous external traffic
  - ```nfdump -R 2018/ -s ip/bytes 'dst host 206.189.69.35'```
- What protocols and ports were used
  - ```nfdump -R 2018/ -s port:p/bytes 'host 206.189.69.35'```
- Supporting Evidence
  - Proxy Log Files
  - DNS Evidence



### Tracking Lateral Movement with Netflow - Kibana
- Top 5 External Source IP Addresses
  - ```not source_ip:172.16.0.0/16```
- Top 5 Internal Source IP addresses
  - ```source_ip:172.16.6.0/24 or source_ip:172.16.7.0/24```
- Search for traffic involving the heaviest-volume internal IP address identified
- Characterize this traffic based on the identified IP address's peers
- What can the ports or other observed characteristics such as timing suggest about the communications
- Suggestions
  - Large-volume sessions
    - Sort by Total Bytes
  - Long-running sessions
    - Time Between Flow Start and Flow End
  - Unanswered TCP connection requests
    - Unanswered reflects only SYN
  - Abruptly/uncleanly closed TCP connections
      - Unclean shutdown includes RST flag
  - Unknown internal IP addresses
  - Geographic concentrations
    - Destination Heatmap Visualizations
  - Traffic spikes, troughs, or plateaus
    - Time Series Graph



## Microsoft Protocols
- SMB is also used for Group Policy distrobution & DCE/RPC



### Windows Architecture
- Primary Communication/Protocols
  - AD Authentication (Kerberos/NTLM)
  - Server Message Block (Domain Auth and GPO)
  - Outlook to Exchange Sync (RPC, RPC via HTTPS, TLS, IMAP, POP3)
  - External Clients (VPN)
  - Sharepoint (HTTP or HTTPS)



### SMB Analysis Goals
- Attacker Actions
  - Where have they been?
  - What have they looked at?
- Detect patterns of activity or targeting



### Filter and Review SMB
- Apply Display Filter
  - Hide GPO Sync, SMB Announcements, Browser Elections