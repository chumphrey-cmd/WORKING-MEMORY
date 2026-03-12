# Web Dev Basics

* Commit frequently, ensure that you're making incremental commits to gradually mark your progress and create a history of the progress you've made on a project!

* `HTML`: blueprints for the home
* `CSS`: design and explict/asthetic details that color and detail the blueprint
* `JavaScript`: what's used to make the house interactive (e.g., automated floodlights, motion sensing cameras, garage, etc.)

* **Dark Pattern**
  * Recommends, Doom scrolling, white background with white X.
  * Overall things that impact usage time of your application.

* Inline Element: only as much as much space as it needs.
* Block Element: all the space is used
* Single Page Application (SPA)

## Front End Frameworks
* `React/Vue` vs the use of Vanilla HTML and CSS
  * `React/Vue` use virtual Document Object Model (DOM) which allow the rendering of web pages to have **low coupling** and is **object-oriented**. When a web page is rendered, the rendering occurs in pieces allows for pieces of the form to be saved to avoid pieces of it being overwritten.
  * Vanilla HTML and CSS have to render the entire web page each time a web app is updated 

## Front End Basics
* `rem (short for "root em")` is a relative unit of measurement in CSS that defines sizes based on the font size of the website's root element. It allows for entire layouts and components to scale proportionally across different sizes.
* Data Transfer Objects (DTOs): https://stackoverflow.com/questions/1051182/what-is-a-data-transfer-object-dto

### Where Does CSS Go?

* Inline CSS: in the same line as your HTML, used for detailed specifics

```hmtl
...

<body style ="background-color:green;">
  <h1> Hey guys, how's it going? </h1>
</body>

...
```

* Internal CSS: where you define the CSS parameters above your HTML.

* External CSS: A separate file (e.g., `styles.css`) calls and passes the parameters and styling to our HTML. Abides by the principle of DRY (**most common**)

### JavaScript
* Typically **ONLY** used to run within the browser!
* `Node.js` is what's used to allow JavaScript to run outside the browswer...
* JS is asynchronous: meaning that it can run without user interaction, JS starts top to bottom but is also able to jump in between your code.
* Associativity:
  * Left to right, except when using assignment which is right to left...
* Precedence:
  * The use of PEMDAS (order of operations...)

### Document Object Model (DOM)

* The hierarchy of your HTML and interact with the elements of the HTML.
  * e.g., interacting with a database

### BootStrap
* Front-end CSS framework to speed up the creation of basic web applications. Essentially, it's a pre-collected 
* From a design standpoint, it's crucial to understand the specific "grid" or UI of the application that you're building...
  * For example, if you anticipate your user base to primarily be mobile, ensure that your styling and spacing is able to account for that end-user device plane

### Consuming APIs
* Serving/Building: creating the access to resources, structure, HTTP Methods, etc.
  * Is the data I need present?
  * Cost?
  * How data is sent?
  * Authentication?

* Consuming: utilization an already built code, data, resources, etc. (e.g., THINK OpenAI, Anthropic, Gemini, etc.)
  * Endpoints?
  * Methods (HTTP)
  * How is data sent?
  * How much is data sent?
  * What does the data look like?

> [!NOTE]
> Your columns when designing applications should ALWAYS add up to 12! 
> You can dynamically include different sizing options within different devices (e.g., large, medium, small)


> [!NOTE] 
> When moving from dev to prod, REMOVE console.log errors as they are a security concern!
> 

# References and Frameworks

* [React.dev](https://react.dev/learn)
* [Vue.js](https://vuejs.org/)
* [CSS Garden](https://csszengarden.com/)
* [Browser Safe Colors](https://147colors.com/)
* [Boot Strap Basics](https://getbootstrap.com/)