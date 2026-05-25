# Backend Testing

## Testing Basics

```java
// 1. Arrange: Create a fake user and a fake quiz
// 2. Arrange: Tell Mockito what to do
// 3. Act: Call the method
// 4. Assert: Check the results
```

* [1. Basic Springboot Setup](https://docs.google.com/document/d/1unguDrrlFYuRG6n1BW2IGNdjnEkR5ZJLAt2yfLr20Ik/edit?tab=t.0)
* Open GitHub Repo
* Navigate to [Spring Initializer](https://start.spring.io/) to create zip file using basic dependencies:
    * H2, SpringWeb, JPA
* Unzip dependencies inside the root of the project.
* Run the following for a sanity check:
    * `./gralew build`
    * `./gradel test`
    * `./gradel bR`

> [!NOTE]
> Order should create @Repository + @Entity > @Service > @Controller

* @Entity: private properties > constructors > getters > setters
    * **NOTE:** you don't want to create everything all at once, you want to create the test incrementally!

* [2. Springboot Backend Setup](https://docs.google.com/document/d/1rZslXBb1X5zd4bfANwwqgNhJ5D3NapGM7gGNy2YLvrc/edit?tab=t.0#heading=h.rafcyfrj339q)

* Singleton and Beans
    * Singleton's are used as a "routing" or manager so that an application only needs to create a single java object for a specific function...

* Testing Through the Layers
    * I need to determine how and when to conduct specific parts of testing through the MVC layers...
    * I'll go ahead and copy and provide each of Java Directories and create a pathway for testing...

## RestAPI Testing

> [!NOTE]
> After your basic CRUD-based application is set up, use the following commands to test functionality.
> Generate a new HTTP Client via: `Tools > Service > Create Request in HTTP Client` and input the example content below.

```http
POST http://localhost:8080/api/v1/APP_NAME
Accept: application/json
Content-Type: application/json

# Format based on your Entity.java 
# CHANGED: Moved this comment OUTSIDE the JSON body. JSON does not support '#' comments, and leaving it inside the curly braces would cause a parsing error.
{
  "title": "Learn TDD",
  "description": "More TDD",
  "isComplete": false,
  "category": {
    "name": "learning"
  }
} 

###

GET /api/v1/APP_NAME
Host: localhost:8080
Accept: application/json

```

* This HTTP Client file acts as a fake "Browser" or front-end. The `POST` block sends a JSON payload to your Controller to create a new record in your database. The `###` acts as a delimiter so you can keep multiple requests in one file. The `GET` block will fetch the data back out to verify your `POST` worked.


## Flyway Migration, `compose.yaml`, and `application.yaml` Setup for PostgreSQL

### Flyway Migration

* Navigate to `src/main/resources`
* Inside of resources, make the following nested directories:
* `db` > `migration`


* Create Flyway Init Migration file.
* Right-click `db/migration` > `New` > `File` > Name it `V1__init.sql` (Note the double underscore).

**What is Flyway??**

* Flyway is a version control system for your database. By placing SQL scripts in this folder, Flyway will run them in order (V1, V2, etc.) right before your Spring app boots up. This guarantees your database tables exist *before* your Java code tries to access them.

### `compose.yaml`

```bash

# Basic Docker Startup...

cd your-spring-boot-project

docker init

docker-compose up --build

docker-compose ps

docker-compose stop

docker-compose start

docker-compose down

docker-compose down -v

```

* Insert the following information into the `compose.yaml`:

```yaml
# compose.yaml template

services:
  postgres-db:
    container_name: CONTAINER_NAME
    image: postgres # using the latest official postgres version
    restart: always
    volumes:
      # Ensures your database data survives container restarts, here we can specific additional backups for our database if needed.
      - ./postgresql_data:/var/lib/postgresql
    environment:
      POSTGRES_USER: YOUR_NAME
      POSTGRES_PASSWORD: password
      POSTGRES_DB: APP_DB_NAME
      POSTGRES_HOST_AUTH_METHOD: password
    ports:
      - "5434:5432" # 5434 (external port) : 5432 (internal port)

# This tells Docker to create and manage a volume named 'postgresql_data' specifically for our database service above.
volumes:
  postgresql_data:
    driver: local
```

* Docker Compose reads this file to spin up an isolated, running instance of PostgreSQL on your machine. The port mapping (`5434:5432`) is crucial: it means your Java app (running on your local machine) must talk to port `5434` to reach the database hidden inside the Docker container.

### `application.yaml`

* Update the following information into `application.yaml`:

```yaml
spring:
  application:
    name: APP_NAME

  datasource:
    url: jdbc:postgresql://localhost:5434/todo # NOTE: this MUST match the external port (5434) from compose.yaml for proper connection!
    driver-class-name: org.postgresql.Driver
    username: YOUR_NAME
    password: password

  jpa:
    hibernate:
      # Since we are using Flyway to manage our database schema, we want Hibernate to only 'validate' that our Java classes match the tables Flyway created. We don't want Hibernate trying to change the tables automatically.
      ddl-auto: validate 
    show-sql: true # Prints the SQL queries Hibernate generates to the console, highly useful for debugging.

  flyway:
    enabled: true
    # this specifies the location of where we created our flyway setup, defaults to db/migration path...
    locations: classpath:db/migration

server:
  port: 8080 # This is the port your actual Spring application runs on, completely separate from the database port.

```

## Spring JPA Overview

* References: 4,5

**Spring Framework Fundamentals:**
At its core, the Spring Framework is a lightweight, open-source framework designed to simplify enterprise Java applications. It relies heavily on **Inversion of Control (IoC)** and **Dependency Injection (DI)**. By using Spring Boot, much of the boilerplate configuration is eliminated, allowing you to run applications with embedded servers easily.

**Object Relational Mapping (ORM) and JPA:**

* **ORM:** A programming technique that allows you to map your Java objects (like your `Todo` class) directly to relational database tables (like a `todos` table).
* **Hibernate:** The default underlying ORM tool used by Spring. It is schema-agnostic, meaning it generates the necessary SQL behind the scenes regardless of whether you are using PostgreSQL, MySQL, or H2.
* **Spring Data JPA:** This module sits on top of Hibernate. It drastically reduces the amount of code you write by allowing you to create "Repositories" (simple interfaces). You don't have to write basic CRUD (Create, Read, Update, Delete) SQL queries anymore; Spring Data JPA handles it for you.

### Query Methods in Spring Data JPA

Based on the official Spring Data documentation, there are a few powerful ways to get data out of your database without writing complex Java code:

1. **Derived Query Methods:** Spring can automatically generate SQL just by looking at the *name* of the method in your Repository interface. For example, if you create a method called `findByIsCompleteTrue()`, Spring parses the method name and automatically writes the SQL to find all completed tasks.
2. **`@Query` Annotation:** If your query is too complex for a derived method name, you can write manual JPQL (Java Persistence Query Language) or native SQL directly above the method using the `@Query` annotation (e.g., `@Query("SELECT t FROM Todo t WHERE t.category.name = ?1")`).

### Annotations

* **`@Repository`:** Marks an interface as a Data Access Object. It tells Spring to implement the interface and manage it as a bean.
* **`@Entity`:** Placed on a Model class (like `Todo.java`). It tells JPA, "This class represents a table in the database."
* **`@Table`:** (Optional) Allows you to specify the exact name of the table in the database if it differs from the class name (e.g., `@Table(name = "todo_items")`).
* **`@Id`:** Marks a specific field as the Primary Key for the database table.
* **`@GeneratedValue`:** *(Clarification from previous notes)* This annotation is responsible for automatically generating the sequential ID numbers (1, 2, 3...) for new records when they are saved. **Flyway** generates the *tables*, but `@GeneratedValue` generates the *primary key values*.
* **`@Column`:** Allows you to map a Java variable to a specific column name in the database, or apply constraints (like `nullable = false`).

# Frontend Testing
* [Front End Testing Cheatsheet](https://testing-library.com/docs/react-testing-library/cheatsheet/)

See **[Guide for Setting Up Frontend for Testing](https://docs.google.com/document/d/1qiwOumIcdrZDpAnouLh2rv4SHVzSiHs_RCKKm7U_Vqs/edit?tab=t.0)** to get official steps.

> [!NOTE]
> Refer to web_dev.md for additional commands for using npm. Basically the same thing as `npm` installation, BUT much faster

* **Dependency Hell:**
    * Major security risk — 2nd, 3rd, 4th order dependency reliance. How to address this? React to them as they arise seems to be the status quo and possibly a career niche.

* `yarn create vite` — scaffolds a new Vite project (same flow as `npm create vite@latest`)
* `yarn add -D vitest @testing-library/react @testing-library/jest-dom jsdom` — installs testing dependencies as **dev dependencies** (the `-D` flag means they won't be bundled into your production build):
    * `vitest` — Vite-native test runner, replaces Jest in a Vite project; reads your `vite.config.js` automatically
    * `@testing-library/react` — provides `render` and `screen` utilities to mount and query React components in tests
    * `@testing-library/jest-dom` — extends Vitest/Jest with DOM-specific matchers like `.toBeInTheDocument()`, `.toHaveTextContent()`, etc.
    * `jsdom` — simulates a browser DOM environment inside Node so your component tests have a DOM to render into
* `yarn run dev` — restart/run the application

* **Live Templates (IntelliJ):**
    * `CMD + Shift + A > Templates > JavaScript Templates` to locate the templates you want to use!
        * `descr` — generates a `describe()` block (groups related tests together)
        * `it` — generates an `it()` / `test()` block (a single test case)

> [!NOTE]
> Front-end tests work in the inverse of backend tests.
> It's a lot about the **interaction of triggers within the UI** — you're simulating what a user *sees and does*, not testing raw data or logic directly.

## Query Types

* [About Queries — Testing Library](https://testing-library.com/docs/queries/about)
* [Priorities with Testing](https://testing-library.com/docs/queries/about#priority)
    * Focus on **what the user interacts with**, not on the DOM structure or implementation details.

Queries are the methods Testing Library gives you to find elements on the page. The difference between query types is what they return and whether they throw an error or retry asynchronously.

### Types of Queries: Single Element

| Query | 0 Matches | 1 Match | >1 Matches | Async/Retry? |
|---|---|---|---|---|
| `getBy...` | Throw error | Return element | Throw error | No |
| `queryBy...` | Return `null` | Return element | Throw error | No |
| `findBy...` | Throw error | Return element | Throw error | **Yes** |

### Types of Queries: Multiple Elements

| Query | 0 Matches | 1+ Matches | Async/Retry? |
|---|---|---|---|
| `getAllBy...` | Throw error | Return array | No |
| `queryAllBy...` | Return `[]` | Return array | No |
| `findAllBy...` | Throw error | Return array | **Yes** |

* **`getBy`**: Use when the element is **static** and should **already be in the DOM** — it returns the element immediately or throws if not found.
* **`queryBy`**: Use when you want to assert an element is **not present** — it returns `null` instead of throwing when nothing matches, making it safe for negative assertions.
* **`find`**: Use when you're expecting to retrieve something **asynchronously** (e.g. after a fetch or state update). Returns a `Promise` and retries until the element appears or times out (default: 1000ms). Always pair with `async/await`.
    * `findBy` is a combination of `getBy` + `waitFor` under the hood.

### Query Priority

Testing Library recommends querying the way a **real user would find an element** — not by class name or ID. Priority order from most to least preferred:

1. **Accessible to Everyone** (prefer these first):
* `getByRole` — queries by ARIA role (e.g. `button`, `heading`, `input`). Top preference for almost everything.
    * Example: `getByRole('button', {name: /submit/i})`
* `getByLabelText` — best for form fields; mirrors how users navigate forms
* `getByPlaceholderText` — fallback if no label exists
* `getByText` — for non-interactive elements like `div`, `span`, `p`
* `getByDisplayValue` — useful for pre-filled form values

2. **Semantic Queries** (HTML5 / ARIA):
* `getByAltText` — for `img`, `area`, `input` with alt text
* `getByTitle` — lower priority; not consistently read by screen readers

3. **Last Resort**:
* `getByTestId` — only use when nothing else fits (e.g. dynamic content). Not visible to users.

## `Async` + `Await` Example
> Example of using `async` and `await` to simulate a user clicking and getting feedback...'

```javascript
it('should count button increment', async () => {

  // Arrange — mount the App component into the jsdom test environment
  render(<App/>)

  // Query for the button by its ARIA role and name (matches text "count")
  // getByRole is preferred because it mirrors how a real user or screen reader finds elements
  const button = screen.getByRole('button', {name: /count/i});

  // Set up a userEvent instance — this simulates real browser interactions
  // (mouse events, focus, keyboard, etc.) more accurately than fireEvent
  const user = userEvent.setup();

  // Assert the button is present and visible in the DOM before interacting
  expect(button).toBeInTheDocument();
  expect(button).toBeVisible();

  // Assert the button's initial label shows 0 (before any clicks)
  expect(screen.getByRole('button', {name: /0/i}));

  // Act — simulate a real user click; await because the click triggers
  // an async state update in React that we need to wait for
  await user.click(button);

  // Assert the button's label has updated to 1 after the click
  expect(screen.getByRole('button', {name: /1/i}));

});
```

## Troubleshooting Basic Vite Testing

You need to check the following files if you run into trouble during testing [reference](https://stackoverflow.com/questions/75482384/vitest-config-doesnt-detect-jsdom-environment):

> [!NOTE]
> ENSURE THAT YOU DON'T MIX PACKAGE MANAGERS TOGEHTER!!!
> If all else fails, delete your `package.json`, `yarn.lock`, and then `yarn`/`npm` install.

* `package.json`: import the following under the `package.json` section

```json
  "scripts": {
"start": "vite",
"build": "vite build",
"compile": "tsc",
"preview": "vite preview",
"test": "vitest run",
"test:watch": "vitest --watch",
"watch": "vitest",
"test:coverage": "vitest --coverage",
"serve": "vite preview",
"test:ui": "vitest --ui",
"prep": "yarn test",
"lint": "biome lint",
"lint:fix": "biome lint --write",
"format": "biome format --write",
"check": "biome check",
"check:fix": "biome check --write"
}
```

* `vite.config.ts`: add the following imports

```ts
import babel from '@rolldown/plugin-babel';
import tailwindcss from '@tailwindcss/vite';
import react, { reactCompilerPreset } from '@vitejs/plugin-react';
import { defineConfig } from 'vitest/config';

// https://vite.dev/config/
export default defineConfig({
  server: {
    port: 3000,
    strictPort: true,
    hmr: {
      clientPort: 3000,
    },
    proxy: {
      '/api': {
        target: 'http://localhost:8080',
        changeOrigin: true,
      },
    },
  },
  plugins: [
    react(),
    tailwindcss(),
    babel({ presets: [reactCompilerPreset()] }),
  ],
  build: {
    outDir: 'build',
  },
  test: {
    globals: true, // Allows using `describe`, `it`, `expect` without imports
    environment: 'jsdom', // Simulates a browser environment
    setupFiles: './src/setupTests.ts', // File for test setup (see below)
    css: false, // Optional: Include CSS in tests if needed
  },
});
```

* `tsconfig.json`

```json
{
  "compilerOptions": {
    "types": ["vitest/globals", "@testing-library/jest-dom"],
    "paths": {
      "@/*": ["./src/*"]
    }
  },
  "files": [],
  "references": [
    { "path": "./tsconfig.app.json" },
    { "path": "./tsconfig.node.json" }
  ]
}
```

* Create `setupTests.ts` file:

```ts
import * as matchers from '@testing-library/jest-dom/matchers';
import { expect } from 'vitest';
import '@testing-library/jest-dom';
import '@testing-library/dom';

expect.extend(matchers);
```

## TDD Procedure - Building a TaskItem Component

> **OVERVIEW**
> 1. Define Type (TaskType.ts)
> 2. Write Test (TaskItem.test.tsx): **RED**
> 3. Build Component (TaskItem.tsx): **GREEN**
> 4. Refactor as needed: **REFACTOR**

### Step 1 - Define the Type (`TaskType.ts`)

Create a **Plain Old TypeScript Object (POTO)** that describes the shape of the data you want to work with. This becomes the single source of truth for what a `Task` looks like across your test and your component.

```typescript
export type Task = {
    id?: number,       // optional — a task may not have an ID yet (e.g. before being saved)
    title: string,
    description: string
}
```

### Step 2 - Write the Test First (`TaskItem.test.tsx`)

Before building the component, write the test that describes **what the component should do**. At this point the test will be **red** (failing) because `TaskItem.tsx` doesn't exist yet.

```typescript
import {render, screen} from "@testing-library/react";
import TaskItem from "../TaskItem.tsx";
import type {Task} from "../TaskType.ts";

describe('Task Item Test', () => {

    it('should display Task Item', () => {

        // Arrange — create a POTO using the Task type from TaskType.ts
        const task1: Task = {id: 1, title: 'First Task', description: 'get task component built.'}

        // Act — render the TaskItem component and pass the task in as a prop
        render(<TaskItem initialTask={task1}/>);

        // Utility — logs a Testing Playground URL to the console so you can
        // visually inspect the rendered DOM and find the right query to use
        screen.logTestingPlaygroundURL();

        // Assert — the list item with aria-label "task" exists in the DOM
        expect(screen.getByRole('listitem', {name: /task/i})).toBeInTheDocument();

        // Assert — the rendered text contains both the title and description
        expect(screen.getByText('First Task: get task component built.', {exact: false})).toBeInTheDocument();

    });

});
```

* `describe()` groups all tests related to `TaskItem` together.
* `it()` defines one specific behavior the component should have.
* `render(<TaskItem initialTask={task1}/>)` mounts the component into the jsdom environment with test data passed in as a prop.
* `screen.logTestingPlaygroundURL()` is a handy debug utility — it prints a URL to the console that opens an interactive view of your rendered DOM, helping you figure out the right query to use.
* `getByRole('listitem', {name: /task/i})` queries by ARIA role (`<li>`) and its `aria-label` — the preferred Testing Library approach.
* `{exact: false}` on `getByText` allows a partial match, so it doesn't matter if there are extra spaces or surrounding elements.

### Step 3 - Build the Component to Pass the Test (`TaskItem.tsx`)

```typescript
import React from 'react';
import type {Task} from "./TaskType.ts";

// Defines the shape of the props this component accepts
type TaskProps = {
    initialTask: Task
}

// Destructure initialTask directly from props
export const TaskItem = ({initialTask}: TaskProps) => {

    return (
        // aria-label="task" is what allows getByRole('listitem', {name: /task/i}) to find this element
        <li aria-label={"task"}>
            {initialTask.id} {initialTask.title}: {initialTask.description}
        </li>
    );

};

export default TaskItem;
```

* `TaskProps` defines the expected prop shape locally — it uses the shared `Task` type from `TaskType.ts` to stay consistent.
* The `aria-label="task"` on the `<li>` is what makes `getByRole('listitem', {name: /task/i})` work — without it, Testing Library can find the `listitem` role but not match it by name.
* The rendered text `{initialTask.id} {initialTask.title}: {initialTask.description}` satisfies the `getByText('First Task: get task component built.', {exact: false})` assertion.

## Frontend Testing Setup (JS + Vitest + React Testing Library)

```bash
yarn add -D vite vitest jsdom @testing-library/react @testing-library/jest-dom @testing-library/user-event @testing-library/dom @vitest/ui @vitest/coverage-v8
```

### Configuration Files

##### `vite.config.js/ts`

```javascript
// import tailwindcss from '@tailwindcss/vite'; // import if using tailwindcss v4+
import react from '@vitejs/plugin-react';
import { defineConfig } from 'vitest/config';

// https://vite.dev/config/
export default defineConfig({
  // 1. DEVELOPMENT SERVER CONFIGURATION
  server: {
    port: 3000,           // Forces the dev server to run on localhost:3000
    strictPort: true,     // Fails if port 3000 is taken, rather than randomly assigning another port
    hmr: {
      clientPort: 3000, // Ensures Hot Module Replacement (live reloading) points to the correct port
    },
    proxy: {
      // Intercepts API calls starting with '/api' and routes them to your backend server
      // This prevents CORS errors during local development
      '/api': {
        target: 'http://localhost:8080', // Your backend URL
        changeOrigin: true,              // Changes the origin of the host header to the target URL
      },
    },
  },

  // 2. VITE PLUGINS
  plugins: [
    react(), // Enables React support, JSX compilation, and Fast Refresh
    // tailwindcss(), // Integrates Tailwind CSS v4 directly into the Vite build process
  ],

  // 3. BUILD CONFIGURATION
  build: {
    outDir: 'build', // Changes the default output folder for production builds from 'dist' to 'build'
  },

  // 4. TEST CONFIGURATION (VITEST)
  test: {
    globals: true,                  // Injects describe, it, expect, vi into the global scope so you don't need to import them
    environment: 'jsdom',           // Simulates a browser DOM so React Testing Library can render components
    setupFiles: './tests/setupTest.js', // Runs this file before tests execute (used to load jest-dom matchers)
    css: false,                     // Disables CSS processing during tests to significantly speed up execution time
  },
});
```

##### `tests/setupTest.js`

Create this file using the path specified in the `vite.config.js` (root). It runs once before the test suite executes to inject custom DOM matchers.

```javascript
// Extends Vitest's expect with matchers like .toBeInTheDocument() and .toHaveClass()
import '@testing-library/jest-dom';

```

##### `package.json`

Add the `test` script to your `scripts` for testing:

```json
"scripts": {
  "dev": "vite",
  "build": "vite build",
  "preview": "vite preview",
  "lint": "eslint src --ext js,jsx",
  
  "test": "vitest", 
  "test:run": "vitest run",
  "test:coverage": "vitest run --coverage",
  "test:ui": "vitest --ui"
}

```
1. `yarn test`: Opens Vitest in "watch mode". It stays open in your terminal and instantly re-runs your tests every time you save a file. (Best for active development).
2. `yarn test:run`: Runs your tests exactly once and closes. (Best for CI/CD pipelines).
3. `yarn test:coverage`: Generates a report showing exactly which lines of your code are *not* covered by tests yet! *(Note: You will need to run `yarn add -D @vitest/coverage-v8` to unlock this).*
4. `yarn test:ui`: Opens a beautiful, interactive dashboard in your browser to view your test runs. *(Note: You will need to run `yarn add -D @vitest/ui` to unlock this).*

```bash
yarn test
```

## Vitest vs Mock Service Worker (MSW)

### Vitest (The Test Runner & Engine)

Vitest is the orchestrator. It doesn't care if you are testing React, Vue, pure JavaScript, or a backend Node.js script.

* It scans your project for `.test.js/ts` files, executes them, provides the test structure (`describe`, `it`), checks conditions (`expect().toBe()`), manages performance, and handles file-level mocking (`vi.mock`).

### React Testing Library (The UI Utility)

RTL is a specialized extension designed for React. It has no idea how to run a test on its own; it requires a runner like **`Vitest`** to exist.

* It handles rendering your React components into the virtual browser environment (`jsdom`) and provides user-centric ways to find elements on the page (e.g., searching for a button by its text, just like a human reader would).

### `vi.mock` / `vi.spyOn` vs. MSW

### Use Vitest (`vi.mock` or `vi.spyOn`) for JS/TS-level logic

If you want to fake a JS/TS module, an external package, a timer, or watch if a specific local function was called, use Vitest.

> **Example:** 
> You want to test a component that uses a third-party library like `uuid` to generate IDs. You don't want real random IDs in your test, so you use `vi.mock('uuid', () => ({ v4: () => 'static-id-123' }))`.

### Use MSW for Network-level requests

> [!NOTE]
> If your app uses **Axios** or **Fetch** use MSW.

* If you mock Axios with Vitest, you are changing your application's actual code implementation during the test. If you accidentally misconfigure Axios in production, your test might still pass because you wrote a fake Axios/fetch request.

* MSW acts like a fake server running in the background. Your application runs its real code, makes a real Axios call, and MSW intercepts it at the network layer to return fake JSON data. This ensures your component's data-fetching code is fully tested.