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

### JavaScript (JS)
* **Runtime Environment:** Typically **ONLY** used to run within the browser! **Node.js** is the environment that allows JavaScript to run "server-side" (outside the browser).
* **Asynchronous (The "Non-Blocking" Nature):** JS is single-threaded, meaning it executes one command at a time. However, it is asynchronous because it uses an **Event Loop**. This allows JS to start a "slow" task (like fetching data) and move on to other code without freezing the browser, "jumping back" once the task is finished.
* **Associativity:** The order in which operators of the same precedence are evaluated.
  * Most are **Left-to-Right** (e.g., arithmetic).
  * **Assignment (`=`)** and **Exponentiation (`**`)** are **Right-to-Left**.
* **Precedence:** Determines the priority of operations (similar to **PEMDAS** in math). Use parentheses `()` to explicitly override precedence.
* **Variable Scoping:** * `const`: For values that remain constant.
  * `let`: For values that will be reassigned.
  * `var`: Legacy syntax; generally avoided in modern dev due to "hoisting" and scoping issues.

### Document Object Model (DOM)
* **The Interface:** A hierarchical, tree-like representation of your HTML. It acts as the bridge that allows JavaScript to "talk to," manipulate, and style HTML elements.
* **Nodes:** Every element, attribute, and piece of text in the HTML is a "node" in the DOM tree.
* **Interaction vs. Storage:** * **Frontend:** The DOM is used to update what the user sees on the screen (the UI).
  * **Backend:** The DOM does **NOT** interact with databases. To get data from a database, JS uses an **API** to fetch the data, then uses the **DOM** to display it.

### Bootstrap
* **Framework:** A frontend CSS framework designed to jumpstart responsive web design using pre-built components (buttons, navs, cards).
* **Mobile-First Philosophy:** Bootstrap is built to scale up. You should design for the smallest screen first (mobile), then use breakpoints to adjust spacing and layout for larger screens (tablets/desktops).
* **The Grid System:** * **Container > Row > Column:** The required hierarchy for the grid to function.
  * **12-Column Rule:** Every row is divided into 12 virtual columns. Your column classes (e.g., `col-6`, `col-md-4`) should always add up to 12 per row.
* **Utility Classes:** Use shorthand classes like `mt-3` (margin-top) or `p-2` (padding) to style elements without writing custom CSS.

### Consuming APIs
* **The Language (JSON):** Most APIs communicate using **JSON** (JavaScript Object Notation), which organizes data into key-value pairs.
* **Serving/Building:** Creating the infrastructure for data access.
  * **Endpoints:** The specific URLs used to access resources (e.g., `/api/users`).
  * **HTTP Methods:** `GET` (Read), `POST` (Create), `PUT` (Update), `DELETE` (Remove).
  * **Authentication:** Usually handled via API Keys or Bearer Tokens.
* **Consuming:** Utilizing existing resources (e.g., OpenAI, Gemini, Weather data).
  * **The Fetch API:** The standard JS method for requesting data from an endpoint.
  * **Status Codes:** `200` (OK), `404` (Not Found), `500` (Server Error).

---

> [!IMPORTANT]
> **Grid Logic:** When designing layouts, ensure your column spans add up to **exactly 12** to maintain alignment. Use responsive classes (e.g., `col-12 col-md-6`) to define how many columns an element occupies on different devices.

> [!WARNING]
> **Production Security:** When moving from development to production, **ALWAYS REMOVE** `console.log` statements. These can leak sensitive application logic or user data to the public browser console, creating a security vulnerability.

## Node.js Basics

* [Node.js Intro](https://nodejs.org/en/learn/getting-started/introduction-to-nodejs)

* Node.js is used primarily for scaffolding projects (setting up structures, installing packages, and running build processes) rather than for mastering its entire API.
* Node.js transformed JavaScript from a client-side language into a versatile, full-stack powerhouse.
* Node essentially allows JavaScript to run outside the browser, with the ability to read and write files, run servers, access databases, and automate tasks.
  * **Built-in Modules**:
    * fs:
    * http:
    * path:
    * events:
    * crypto:


* `npm init -y`
  * `-y`: used to accepts the defaults for you project.
  * Serves to create a dependency `.json` file for your project.
  * Create a `package.json` file that serves as the "driver file" or the initializing file (e.g., `public static void main(String[] args)` inside of your `Main.java`)

* `touch index.js`
  * Creates "driver" or starting point for our application.

* `npm i <name_of_package>`
  * Install the package that you want to actually install.
  * `package.json` vs `package-lock.json`
    * `package-lock`: primarily provides the specifics and "pinned versions" of all the dependencies that your applications are using.
    * `package`: the base template and "blueprints" that are needed to run the application.

> [!WARNING]
> Ensure that you've validated the actual package that you want to download for you web-app, this is easy hunting ground for potential threats to exploit individuals devs via drive by downloads!

* `import packages`:

```js
const catMe = require("<name_of_package>")
console.log(catMe())
```

```bash
# Simple way to run catMe() function to get ASCII art...
node index.js
```

## TypeScript Setup Basics

* Reference: [TS Setup](https://www.geeksforgeeks.org/typescript/how-to-setup-a-typescript-project/)

### Initial Project Initialization
1. **`npm init -y`**: Creates a `package.json` file with default settings. This is the "ID card" for your project.
2. **`npm install -D typescript`**:
  * **`-D` (Dev Dependency):** Installs tools needed only during development (like the compiler). These are **not** bundled into the final production code, which keeps your app lightweight.
3. **`npx tsc --init`**: Generates the `tsconfig.json` file. This is where you tell TypeScript how to behave (e.g., where to find files and where to put the converted JavaScript).

### Project Structure
To avoid the "No inputs found" error, always organize your code:
* **`mkdir src`**: Create a source folder.
* **`touch src/index.ts`**: Create your main entry point inside that folder.

**Simple `tsconfig.json` Setup**

* Include the following within the `tsconfig.json` default:
```json
{
  // Visit https://aka.ms/tsconfig to read more about this file
  "compilerOptions": {
    "module": "CommonJS", // Basics module that is used to compile our project!
    "target": "ES2022", // Year of JS that we want, be sure you have the correct year selected when compiling!
    // File Layout
    // "rootDir": "./src",
    "outDir": "./build",
    "removeComments": true
  },

  // the ** is a wild card to identify any level of directories that our application should look through until we hit a *.ts file.
  "include": [
    "./src/**/*.ts"
  ]
}
```

### Common Commands & Tips
* **`npx tsc`**: Runs the compiler once to turn your `.ts` into `.js`.
  * `tsc` = transcript compiler
* **`npx tsc -w`**: Starts "Watch Mode"—it stays open and re-compiles every time you hit Save.
* **`npm i`**: Short for `npm install`. Run this immediately after downloading a project to install all required libraries listed in the `package.json`.

> [!TIP]
> **Type Definitions:** While you don't always need to "import packages" for TypeScript's core features, you often need to install "Type Definitions" for external libraries so TS understands them.
> *Example:* `npm install -D @types/node` (This helps TS understand Node.js specific commands like `process` or `__dirname`).

> [!NOTE]
> **Node Modules:** Never manually edit the `node_modules` folder. If you need to add or update a package, always use `npm install <package-name>`.

**Destructuring**
* `let {fname, lname, associates} = person`
  * Here we are assigning the common nesting options to the "person" keyword that allows you to access specific arrays much easier!

# References and Frameworks

* [React.dev](https://react.dev/learn)
* [Vue.js](https://vuejs.org/)
* [CSS Garden](https://csszengarden.com/)
* [Browser Safe Colors](https://147colors.com/)
* [Boot Strap Basics](https://getbootstrap.com/)