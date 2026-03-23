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

#### Common Commands & Tips
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

## React + Vite (Vanilla JS)

### Vite

* [Vite](https://vite.dev/guide/) is a build tool that aims to provide a faster and leaner development experience for modern web projects and provides a dev server and build commands that bundle your code and allow you to push the content to production.

* Create project folder and run the command below inside of that new directory

```bash
npm create vite@latest
```

* Select framework: `React`
* Select a variant: `JavaScript` or `TypeScript`
* Install with npm and start now? `Yes`

```bash
npm install
```

```bash
npm run dev
```

> Running `npm run dev` starts Vite's local dev server (default: `http://localhost:5173`) with **Hot Module Replacement (HMR)**, meaning changes you make in your code reflect in the browser instantly without a full page reload.

#### File Structure and Communication

Overall flow of how the files talk to each other:

```
index.html  →  main.jsx  →  App.jsx  →  (your components)
                   ↑
           Vite processes everything
           via esbuild under the hood
```

* **`index.html`**: The entry point and skeleton of the application — similar to a regular HTML file. It contains a single `<div id="root"></div>` which is the mount point where React injects the entire application.

* **`main.jsx`**: The JavaScript entry point. It imports React and `App.jsx`, then uses `ReactDOM.createRoot()` to attach (mount) the `App` component to the `#root` div in `index.html`. Think of it as the bridge between your HTML and your React components.

* **`App.jsx`**: The top-level React component and the root of your component tree. All other components branch out from here. This is where you'll eventually set up routing and import child components. 

* **`vite.config.js`**: Configures Vite's build and dev behavior. Out of the box for a React project, it loads the `@vitejs/plugin-react` plugin which enables JSX support, Fast Refresh (HMR), and other React-specific features. You can also customize the dev server port, build output directory (`dist/`), and add other plugins here.

* **`eslint.config.js`**: Defines the linting rules applied to your code. Catches syntax issues, enforces code style, and flags potential bugs before they cause problems at runtime.

* **esbuild (under the hood)**: Vite uses **esbuild** to transpile and convert `.jsx` files into plain JavaScript that the browser can understand. 
  * `esbuild` is significantly faster than Babel and handles the JSX transform automatically via the `@vitejs/plugin-react` plugin. 

  > **Note on Babel**: Older React setups (like Create React App) used Babel for JSX transpilation. Vite replaced this with esbuild for speed, so you do **not** need to configure Babel manually in a fresh Vite project.

* **`public/`**: Holds static assets (images, fonts, icons) that are served as-is and do not go through Vite's build pipeline.

* **`src/assets/`**: Also holds assets (like images), but these *are* processed by Vite — useful when you want to import an image directly inside a component.


### React + TypeScript + Vite

* The file structure is nearly identical to the Vanilla JS setup, with a few key differences:
  * File extensions change from `.jsx` → `.tsx` and `.js` → `.ts`

#### Additional Files (TypeScript-Specific)

* **`tsconfig.json`**: The base/root TypeScript config. It doesn't contain many settings itself — it acts as the top-level reference that points to the two environment-specific configs below using `"references"`.

* **`tsconfig.app.json`**: TypeScript config specifically for your **app source code** (everything in `src/`). This targets the **browser** environment and is what Vite uses when building your React components and pages.

* **`tsconfig.node.json`**: TypeScript config for the **Node.js** environment — specifically for Vite's own config file (`vite.config.ts`) and any build scripts. Browser APIs are not available here; it targets what Node can run.

  > **In short:** your app code runs in the *browser* (uses `tsconfig.app.json`) and Vite itself runs in *Node* (uses `tsconfig.node.json`). They need separate configs because they are two completely different runtime environments.
  
#### Expanding `eslint.config.js` for TypeScript

For a production app or stricter type safety, upgrade the `eslint.config.js` to **type-aware lint rules** by swapping in the templates [here](https://github.com/vitejs/vite/tree/main/packages/create-vite/template-react-ts).

* `tseslint.configs.recommendedTypeChecked` — enables lint rules that require TypeScript's type information (e.g. flags `any` types, unsafe assignments) rather than just syntax-level checks.
* `tseslint.configs.strictTypeChecked` — an optional stricter version; good for production apps
* `tseslint.configs.stylisticTypeChecked` — optional stylistic/consistency rules (naming conventions, etc.)
* `parserOptions.project` — tells ESLint which `tsconfig` files to use so it can read type info during linting.
* `tsconfigRootDir: import.meta.dirname` — ensures the path to your tsconfig files resolves correctly relative to the project root.

## Front End Frameworks

### React

#### React vs Vanilla HTML/CSS/JS

**React** [1]:
* JavaScript *library* (not a full framework) for building user interfaces, especially single‑page applications (SPAs).
* React uses routing (`React Router`), state management (`Redux/Zustand/Context`), and meta‑frameworks (`Next.js`) to complete the SPA stack.

**Vanilla HTML/CSS/JS**: 
* You manually manipulate the real Document Object Model (DOM) (e.g., `document.querySelector`, `innerHTML`) for every change; React lets you *declare* what the UI should look like for a given state and handles DOM updates automatically.
* Must often re‑render the entire page (or large manual DOM fragments) whenever the app changes, which is slower and more error‑prone.

#### Single‑Page Application (SPA)
* The entire app loads once; navigation and data updates happen without full page reloads.
* SPAs use **virtual DOM** which allows React keep an in‑memory, lightweight copy of the real DOM. When state changes:
  1. React re‑renders only the affected components into a new virtual tree.
  2. It **diffs** the new tree against the previous one.
  3. It applies *only* the minimal set of changes to the real DOM (batched).
* This gives **low coupling** between UI pieces and makes updates **declarative** and **component‑based** (similar to OOP).
* When a page is rendered, it happens in *component pieces*; each component can maintain its own state, so pieces are *not* overwritten when other parts update.

#### JSX 
* **JSX:** HTML‑like syntax inside JavaScript that compiles to `React.createElement` calls.

#### Vitest (Vite)
* Basically a modern testing framework that comes bundled with `Vite`.

# References

1. [React.dev](https://react.dev/learn)
2. [Vite](https://vite.dev/guide/)
3. [reactjs.koida](https://reactjs.koida.tech/react-fundamentals/lesson-8-understanding-the-main-files-app.jsx-and-main.jsx)
2. [Vue.js](https://vuejs.org/)
3. [CSS Garden](https://csszengarden.com/)
4. [Browser Safe Colors](https://147colors.com/)
5. [Boot Strap Basics](https://getbootstrap.com/)