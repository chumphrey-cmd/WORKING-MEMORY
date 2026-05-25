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

# References
1. https://www.geeksforgeeks.org/dsa/control-structures-in-programming-languages/
2. https://www.geeksforgeeks.org/software-engineering/mvc-framework-introduction/
3. https://geeksforgeeks.org/dsa/time-complexities-of-all-sorting-algorithms/
4. https://www.geeksforgeeks.org/advance-java/spring/
5. https://docs.spring.io/spring-data/jpa/reference/jpa/query-methods.html