# Test Driven Development (TDD)

## Laws of TDD
* You are not allowed to write any production code unless it passes failing unit tests.
* You are not allowed to write any more of a unit test than is sufficient to fail; and compilation failures are failures.
* Don't write any more production code than is enough to pass ONE failing unit test. Test in isolation, do not change, and test more than one variable at a time.

## Testing Types vs Levels

### Types

* **White Box vs Black Box**
    * White Box: Tester has full knowledge of the internal code/structure (e.g., looking at the Java classes, methods, and logic).
    * Black Box: Tester has no knowledge of the internal code — only tests inputs and outputs (e.g., using the application like a normal user).

* **Automated vs Manual**
    * Automated: Tests are written as code (e.g., JUnit 5 tests) and run automatically every time the build runs — fast, repeatable, and cheap.
    * Manual: A human tester manually clicks through the application — slower and more expensive but great for exploratory or usability testing.

* **Random vs Directed**
    * Random: Tests are chosen randomly to simulate real-world unpredictable usage.
    * Directed: A specific test that is intentionally written to test edge/corner cases (e.g., what happens when a user enters a negative number, null value, or maximum allowed input).

* **Functional vs Non-functional**
    * Functional: Does the application do what it is supposed to do? (e.g., “Does the login button actually log the user in?”)
    * Non-functional: Focuses on how well the application performs (e.g., Security requirements, performance, scalability, usability, reliability).

### Levels

* **Unit**
    * E.g., The integration of methods within Classes. Smallest level — testing one method or one class in isolation (usually with JUnit 5).

* **Integration**
    * E.g., The interaction between Units. Tests how different modules or layers work together (e.g., Controller calling Service calling Repository).

* **End-to-End (System Integration)**
    * E.g., Testing against original outcomes and expectations. Tests the entire application flow from start to finish, just like a real user would experience it.

* **User Acceptance Testing (UAT)**
    * E.g., Walking the user through using the new feature. Real business users validate that the software meets their actual business needs before it goes live.

* **Alpha Testing**
    * E.g., Letting users experiment and use the application. Internal testing done by the development or QA team in a controlled environment (pre-release).

* **Beta Testing**
    * E.g., Observing a set number of users (beta-testers) that directly supervise and work with R&D. Real external users test the application in their own environment and provide feedback.

* **Regression Testing**
    * E.g., Running a set of small tests... A bunch of small test cases that combine together and run miniature tests that will generate bugs that will need to be resolved. Re-running previous tests after changes to make sure new code didn’t break existing functionality.

* **Requirement Traceability Matrix (RTM)**
    * E.g., PM functions. A document/table that maps every requirement to its test cases — ensures nothing is missed and everything is tested (mostly used by Project Managers).

* **Line Coverage**
    * Measures what percentage of your actual code lines were executed by the tests (e.g., 85% line coverage means 85% of your Java code was run during testing).


## TDD Steps and Pyramid
* **Arrange** – Instantiate the test
* **Act** – Trigger the action
* **Assert** - Expected results

> [!NOTE]
> Think about the idea of [laboratory research](https://medium.com/checkout-com-techblog/scientific-methodology-test-driven-development-2570250dc1ae) where you **ONLY** modify single variables, annotate those changes, verify the results, and then conduct additional experiments...

### Testing Pyramid

<img src="./images/testing_pyramid.png">

* **Unit Tests**: run very fast, there should be lots of these. This covers at the unit (methods and class) level. Allows you to have a higher confidence that the feature implementation is successful.
* **Integration Testing (Service Tests)**: Test the compatibility with other methods, classes, or objects within your code base.
* **End-to-End Tests (UI Tests)**: Slower, simulate the user actually interacting with the application.

> [!NOTE]
> The core of this concept is to feed into CI/CD and scalability.
> If you continually develop and approve unit tests, you'll be able to have a higher degree of confidence in what you're shipping.

## TDD and JUnit
* JUnit is just a modern Unit Testing framework that can be used across different IDEs that comes with a variety of assertions dependent on the modules that you import (e.g., `org.junit.jupiter.api.Assertions`).

### Equality and Comparison Assertions

These check if values match or meet conditions useful for validating method outputs in web apps, like comparing expected JSON data or entity fields.

* **assertEquals(expected, actual)**: Checks if two values are equal (handles primitives, objects with equals()).

```java
assertEquals(200, response.getStatusCode()); // Verifies HTTP OK status.
```

* **assertNotEquals(unexpected, actual)**: Opposite of above; ensures they're not equal.

```java
assertNotEquals(0, userList.size()); // List shouldn't be empty after query.
```

* **assertSame(expected, actual)**: Checks if two references point to the same object (identity equality).
* **assertNotSame(unexpected, actual)**: Ensures they're not the same object.

### Boolean Assertions
Great for flag checks or condition validations, like verifying authentication states.
* **assertTrue(condition)**: Checks if a boolean is true.

```java
assertTrue(user.isActive()); // User account should be active.
```

* **assertFalse(condition)**: Checks if a boolean is false.

```java
assertFalse(service.hasErrors()); // No errors after processing.
```

### Nullness Assertions
Essential for handling optional returns or ensuring no nulls where forbidden, common in data access layers.
* **assertNull(actual)**: Checks if the value is null.

```java
assertNull(repository.findById(invalidId)); // No entity for bad ID.
```

* **assertNotNull(actual)**: Checks if the value is not null.

```java
assertNotNull(controller.getResponse()); // Response should exist.
```

### Exception Assertions
Critical for testing error handling in web apps, like validating that invalid input throws an exception.
* **assertThrows(expectedType, executable)**: Expects the code block to throw a specific exception.

```java
assertThrows(IllegalArgumentException.class, () -> service.process(null)); // Null input should fail.
```

* **assertDoesNotThrow(executable)**: Ensures no exception is thrown.

```java
assertDoesNotThrow(() -> validator.validate(validObject));
```

### Collection and Array Assertions
Handy for testing lists or arrays, like API response payloads.
* **assertArrayEquals(expectedArray, actualArray)**: Checks if arrays are equal.
* **assertIterableEquals(expectedIterable, actualIterable)**: For lists/sets; checks equality in order.
* **assertAll(executables...)**: Groups multiple assertions; all must pass (useful for batch checks without early failure).

> [!NOTE]
> In modern Java web dev (e.g., Spring Boot), these cover 80-90% of unit test needs.


### TDD Example(s)
```java
class CalcTest {

    static Calc calc ;

    // Arrange

    @BeforeAll // BeforeAll allows you to automatically create a new instance (i.e., a distributed Arrange)
    static void beforeAll() {

        calc = new Calc() ;
    }

    @Test

    void shouldAddTwoIntegers() {

        // Act
        int actual = calc.add(1, 2) ;

        // Assert
        assertEquals(3, actual) ;
    }
```

# Spring Boot Application Framework

* Spring Boot is a modern Java Web Development Framework that standardizes and streamlines the Web Application process when working with Java. It builds directly on the core Spring Framework (which handles dependency injection and the container) but adds "batteries-included" features like autoconfiguration, embedded servers (e.g., Tomcat), and starter dependencies.
    * Dependency injection annotating the specific values that are called and ran at start up (e.g., @Mockioto)

> [!NOTE]
> Essentially, it's an all-in-one backend framework with front-end(ish) capabilities (it's not a dedicated front-end framework like React or Vue). It provides all the built-in tools for database interactions (via Spring Data JPA for CRUD).
> This solves the problem of boilerplate code in plain Spring, making it faster to get a production-ready app up (e.g., no need to manually set up XML configs for everything).

* Spring Boot basically takes the bespoke business logic of your enterprise environment (e.g., the unique ways that you want to interact and display your company's proprietary data via dashboards, internal applications, public-facing applications, etc.), moves that `.java` file into the "Spring Container," and then securely configures your application.

## Spring Overview

<img src="./images/spring_overview.png">

* Your .java files (POJOs [Plain Old Java Objects]) get "injected" into the Spring Container (also called the IoC-Inversion of Control—container), where Spring handles wiring them up securely based on metadata (annotations like `@Controller`, `@Service`, `@Repository`).

## Spring Container - Simplified (`Controller`, `Service`, `Repository`)
* Digging a bit deeper into the Spring Container itself, there's the `Controller`, `Service`, and `Repository` sections that form its layered architecture of modern Java Web Apps.

<img src="./images/spring_boot_container_simple.png">

* Overall request flow (`Client` → `Controller` → `Service` → `Repository` → `Database`, with `Entity.java` as the data model).

* At a 10,000 ft view, the `Controller` interacts with the end-user's web browser via HTTP request/response methods.
* It's the entry point for user interactions, handling HTTP requests/responses from the browser or client (e.g., via `@RestController` for REST APIs).

<img src="./images/controller_http_methods.png">

> [!NOTE]
> General overview of what's happening the controller at a high-level.
> Shows the Controller handling HTTP methods (e.g., `GET`, `POST`, `PUT/PATCH`, `DELETE`).

* `Service` acts as the conduit and intermediary/business logic that is needed to interact with the request/response method that the controller sends.
* It processes the request (e.g., validations, calculations), calls the `Repository` as needed, and keeps things decoupled
* I view the `Service` portion of the container as the "**Orchestrator**" for the application (this is basically where your bespoke enterprise rules live).

* `Service` then forwards the `Controller` requests to `Repository`, which is what directly interacts with the database (e.g., PostgreSQL) to perform CRUD operations.

> [!NOTE]
> HTTP methods like `GET`, `PUT`, `DELETE`, `PATCH` are used at the `Controller` level, `Repository` uses JPA methods like `findAll()`, `save()`, `deleteById()` to map to SQL queries.

# Model View Controller (MVC)

* Model-View-Controller (MVC) is an architectural/design pattern that separates an application into three main logical parts: `Model`, `View`, and `Controller`.
* It ensures that code is more modular, testable, and maintainable-solving issues. It exists to decouple data management (Model), user interface (View), and input handling/orchestration (Controller), allowing independent development and scaling [2].

> [!TIP]
> The MVC setup includes `Entities` (data objects), `Services` (business logic), and `Repositories` (DB access). This is why annotations like `@Entity`, `@Service`, and `@Repository` are used with backend development because they mark classes to fit into Spring's MVC flow.

* `@Entity` tags a specific .java file and sets the conditions for the type of data that the object is going to expect...

<img src="./images/Spring-MVC-Architecture.png">

> Here, the `Browser` sends requests to `Controller`, which manipulates the `Model` (including Repositories ↔ Database, Entities, Services, Components), then renders the `View`, which displays data from the `Model` back to the `Browser`.

## Controller
* Is the central "connector" or "intermediary" between the client browser, rendering incoming requests, and orchestration. It coordinates the flow, processes some business logic, manipulates data using the `Model`, and interacts with the `View` to display the specific outputs.
* The controller also receives user input and interprets it.
* Updating the `Model` based on user actions.
* Selecting and displaying the appropriate View.

## View
* Generates a UI for the user.
* Views are created by the data collected by the Model component, but it's often passive and relies on the `Controller` to pass that data.
* It **ONLY** interacts with the `Controller`.
* The primary purpose is to take the rendered view of that data and display that information for the end user.

## Model
* This section seems to be the meat-and-potatoes and backend work that is required to actually interact with the database.
* Thinking out the lecture in class today, we used annotations (e.g., `@Repository` and `@Service`) to mark specific sections inside our Java application.
* Managing data: CRUD (Create, Read, Update, Delete) operations.
* Enforcing business rules.
* Notifying the `View` and `Controller` of state changes (via observer patterns in classic MVC; in web frameworks like Spring, the Controller often fetches updates from the Model and pushes them to the View).

# Spring Boot + MVC by Layers

<img src="./images/springboot_by_layers.png">

* **Browser** sends a `request` to the **Controller**.
* The **Controller** `manipulates` the **Model**.
* The **Model** (which contains **`Repositories`**, **`Entities`**, **`Services`**, and **`Components`**) communicates back and forth with the **Database**.
* The **Model** `displays` information to the **View**.
* The **Controller** `renders` the **View**.
* The **View** sends the final response back to the **Browser**.

## Spring Annotations and Testing Strategies

**@Controller**

* Accepts (POST, GET, PUT, ...) requests
* Is tested by @MockMVC
* Calls @Service
* Should keep the controller skinny (or dumb)

*(Flows to)* **@Service**

* Does the business logic
* Tested with @Mockito
* Calls @Repository

*(Flows to)* **@Repository**

* Handles the database transactions
* Only test custom queries w/ @SpringBootTest
* Uses @Entity objects

*(Flows to)* **@Entity**

* Relationship to database table and columns
* Needs @Id field
* Defines your objects

## Sping Boot Setup and Walk-Through
* Autowire used in testing to connect to a Repository
* Primitives vs non-primitives when using IDs:
    * We want non-primitives here because we want our database to generate the value for us.
* Method Overloading: useful when UPDATING our database, rather than modifying the original method constructor, we would just add a smaller constructor...

* Integration Testing is identified by the crossing of boundaries...
* A good indicator of integration is the abscence of "Mocking" within each layer

## Spring Boot Layered Architecture & Testing Flow

* This is the standard bottom-up order used in Spring Boot (Entity → Repository → Service → Controller → Client).
* We **setup** each layer first, then **test** it in isolation before moving to the next. This catches bugs early and keeps tests fast.

### 1. Entity Layer (The Base / Data Blueprint)
* `Entity` is a plain Java class that defines the "shape" of your data and maps to a database table.

```java
@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false, unique = true)
    private String username;
    
    @Column(nullable = false)
    private String email;
    
    private String password;
    // getters + setters (or use Lombok)
}
```

* **Testing**: Minimal (usually just `@DataJpaTest` to check mappings/constraints).
* Used to make sure the table structure is correct before anything else touches it.
* We're basically aligning the data types we've decided to use within our database to the the `Entity.java`.

### 2. Repository Layer (Database Bridge)
* **Setup**: An interface that extends `JpaRepository` and works directly with your Entity.

```java
@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByUsername(String username);
    List<User> findByEmailContaining(String keyword);
}
```

* **Testing**: `@DataJpaTest` (uses H2 database dependency).
* Used to ensure CRUD and custom queries work with the `Entity`.

> [!NOTE]
> We are using the **Non-primitive Type** of `Long` to prevent the use of `null` values being generated when we interact or update the database with values.

### 3. Service Layer (Business Logic & Orchestrator)
* `@Service` class that receives the Repository via dependency injection and adds rules.

```java
@Service
public class UserService {
    private final UserRepository repository;

    public UserService(UserRepository repository) {
        this.repository = repository;
    }

    public User createUser(User user) {
        if (user.getUsername() == null) throw new IllegalArgumentException("Username required");
        return repository.save(user);
    }

    public List<User> getAllUsers() {
        return repository.findAll();
    }
}
```

* **Testing**: `@ExtendWith(MockitoExtension.class)` (pure unit test — no Spring context).
* Here we use **@Mock** and **@InjectMocks**:
    * `@Mock` creates a fake/stub version of the Repository.
    * `@InjectMocks` injects that mock into the Service under test.

* **@MockitoBean** is also used here when we want Spring to replace a real bean with a mock/stub during integration tests. We use this to test only business rules/logic.

* **@Mock** = the **Mirror**  
  → This is the fake/stub object (e.g., a fake `UserRepository`).  
  It “reflects” exactly what you tell it to reflect.  
  You program it with `when(...).thenReturn(...)` — you control the image it shows.

* **@InjectMocks** = the **Object standing in front of the mirror** (the class under test)  
  → This is your real `UserService`.  
  Mockito automatically injects the mirror (@Mock) into it (via constructor, field, or setter).  
  The Service now “sees” the fake reflection and does its work.

* **The Test validates the reflection**  
  → You call methods on the `@InjectMocks` object and assert on the results.  
  You are checking what the Service produces when it looks into the mirror (the fake dependency).

**Simple Heuristic:**
* You create the mirror (`@Mock`)
* You place the real object in front of it (`@InjectMocks`)
* You look at what the mirror shows you (`assertEquals`, `assertThrows`, etc.)

### 4. Controller Layer (HTTP Entry Point)
* `@RestController` that receives requests from the client and calls the Service.

```java
@RestController
@RequestMapping("/api/users")
public class UserController {
    private final UserService service;

    public UserController(UserService service) {
        this.service = service;
    }

    @PostMapping
    public ResponseEntity<User> create(@RequestBody User user) {
        return ResponseEntity.ok(service.createUser(user));
    }

    @GetMapping
    public List<User> getAll() {
        return service.getAllUsers();
    }
}
```

* Use `@WebMvcTest(UserController.class)` + **@MockMvc** for testing
    * `@MockMvc` lets you simulate full HTTP requests against specific paths (e.g., `/api/users`) without starting a real server.
    * It tests the entire controller layer based on the exact path and checks status codes, JSON responses, etc.

#### API Testing of Endpoints
* Using Mockito (via `@MockitoBean` or `@Mock`) to "mock" the action of the database (or Service layer).
* It's a fake/reflected implementation of the "shape" or entity (relationship to database).
* **WHEN** an action occurs (e.g., a GET or POST hits the endpoint) **THEN** return something specific (the mocked response).

This lets you test the **entire endpoint** (request → controller → response) without touching the real database or Service (very efficient).

> [!NOTE]
> **SECURITY**:
>
> When your controller uses `@AuthenticationPrincipal OidcUser oidcUser`, it pulls the logged-in user from the Identity Provider (e.g., Google, Okta, E-EMAS).
> In tests we mock this to simulate authenticated users making requests.

* **@MockitoBean** is commonly used here too. It replaces the real Service with a stub so you can control exactly what the controller receives.

### 5. Client Layer (Frontend – React / Angular / etc.)
* Sends HTTP requests (fetch / Axios) to your Controller endpoints.

```jsx
// Example React service
const createUser = async (userData) => {
    const response = await axios.post('/api/users', userData);
    return response.data;
};
```

* **Testing**:
    * Unit: Jest + React Testing Library (mock Axios)
    * End-to-End: Cypress / Playwright (real browser → real backend)

* Here we are confirming the full round-trip works (user clicks → backend → database → UI updates).

### Overall Testing Order (Bottom-Up)
1. Entity → `@DataJpaTest`
2. Repository → `@DataJpaTest`
3. Service → Mockito (`@Mock` + `@InjectMocks`) or `@MockitoBean`
4. Controller → `@WebMvcTest` + `@MockMvc` (with `@MockitoBean` and mocked `@AuthenticationPrincipal OidcUser`)
5. Full stack / Client → `@SpringBootTest` or Cypress E2E


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

# Front End Testing
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

* **`getBy`**: Use when the element is **static** and should already be in the DOM — it returns the element immediately or throws if not found.
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

# References
1. https://www.geeksforgeeks.org/dsa/control-structures-in-programming-languages/
2. https://www.geeksforgeeks.org/software-engineering/mvc-framework-introduction/
3. https://geeksforgeeks.org/dsa/time-complexities-of-all-sorting-algorithms/
4. https://www.geeksforgeeks.org/advance-java/spring/
5. https://docs.spring.io/spring-data/jpa/reference/jpa/query-methods.html