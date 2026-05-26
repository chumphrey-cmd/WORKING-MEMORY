# Extreme Programming (XP)

[Extreme Programming](https://en.wikipedia.org/wiki/Extreme_programming) (XP) is a software development methodology intended to improve software quality and responsiveness to changing customer requirements. As a type of agile software development, it advocates frequent releases in short development cycles, intended to improve productivity and introduce checkpoints at which new customer requirements can be adopted.

Currently, I'm reading *XP Explained* by Kent Beck. The basic tenets are as follows:
* XP is a lightweight, efficient, low-risk, and flexible way to produce software.
* It focuses on continuous feedback from short cycles.
* Incremental planning of features.
* Flexibility in scheduling and implementation of functionality.
* It focuses heavily on automated tests (e.g., JUnit5 for backend, Jest for frontend testing). **Writing tests for your applications developed via XP is non-negotiable; if you don't write tests, then you aren't doing XP!**
* It relies on the close **collaboration of programmers with ordinary skills**.
* Other elements of XP include: programming in pairs, extensive code review (pairing is essentially continuous code review), not programming features until they are actually needed, a flat management structure, code simplicity and clarity, and frequent communication with the customer.
* The methodology takes its name from the idea that the beneficial elements of traditional software engineering practices are taken to "extreme" levels.

## Manifesto for Agile Development

* https://agilemanifesto.org/
* **Individuals and interactions** over processes and tools
* **Working software** over comprehensive documentation
* **Customer collaboration** over contract negotiation
* **Responding to change** over following a plan

> [!NOTE]
> While there is value in the items on the right, we value the items on the left more.

## Development Principles

### Don't Repeat Yourself (DRY)
* Extracting repeatable functions and logic to make them modular and reusable across your application.
* *Goal:* Reduce technical debt by ensuring that a change in business logic only needs to be updated in one place.

### You Ain't Gonna Need It (YAGNI)
* Write the minimum functionality POSSIBLE to accomplish the immediate goal.
* **Lean slice:** Build strictly to the specifications of what is needed *right now*.
* Skip building out "future-proof" features until there is an actual business requirement for them.
* Write code for today's problems, not tomorrow's hypothetical problems.

### Tell - Don't Ask
* Tell objects what to do, don't ask them about their state to make decisions for them outside of the object.
* Call methods that perform actions *inside* the objects themselves.
* *Why:* It keeps data and the logic that operates on that data bound closely together, reducing loose coupling and massive `if-else` chains in your main application flow.

### SOLID Principles
* **Single Responsibility Principle (SRP):** A class should only have one reason to change, splitting large classes into smaller, focused ones.
  * *E.g.,* If a class is over a certain amount of lines in length, or handles both database saves and UI rendering, split it.
  * *E.g.,* In Linked Lists: The `Node` class only cares about holding data and a pointer, while the `LinkedList` class handles the insertion/deletion logic.
* **Open-Closed Principle (OCP):** Software entities should be open for extension, but closed for modification. Promotes stability and preserves tested behavior.
  * *E.g.,* Extending functionality by adding new classes or overloading methods, without altering the existing, working internal code of the parent. Avoids breaking existing dependencies.
* **Liskov Substitution Principle (LSP):** A superclass should be replaceable with objects of a subclass without affecting the correctness of the program. The minimum functionality for something to work should be inside the parent, and all subclasses can inherit and safely be used in its place.
  * *E.g.,* `AccStudent` (has an ACC ID, email, name). The subclasses (`SwfAccStudent`, `TraditionalAccStudent`, `NonTraditionalAccStudent`) all extend the base `AccStudent`. If a function expects an `AccStudent`, passing it a `SwfAccStudent` shouldn't crash the program.
* **Interface Segregation Principle (ISP):** Clients should not be forced to depend on interfaces they do not use. Keep interfaces small, specific, and relevant.
  * *E.g.,* Instead of one giant `IWorker` interface with `work()`, `eat()`, and `sleep()` methods, split it into `IWorkable`, `IEatable`, and `ISleepable`. This way, if you create a `Robot` class, it only has to implement `IWorkable` and isn't forced to write a useless, empty `eat()` method.
* **Dependency Inversion Principle (DIP):** High-level modules should not depend on low-level modules; both should depend on abstractions (interfaces).
  * *E.g.,* Your `PaymentProcessor` class shouldn't depend directly on a hardcoded `StripeAPI` class. Instead, it should depend on a generic `PaymentGateway` interface. This makes it trivial to swap Stripe for PayPal later, or to mock the database/API during testing.

# Pairing Practices

## What is Pairing?
* Pair programming is an agile software development technique where two developers work together at a single workstation (or shared screen). One types the code while the other actively reviews, strategizes, and checks for defects. It is essentially real-time, continuous code review and knowledge sharing.

## Types of Pairing
* **Discipline Pairing:** Pairing within your own discipline. Two people of the same role (e.g., two backend engineers) work on the same problem at the same time on the same machine.
* **Cross-Discipline Pairing:** Pairing with people in different disciplines (e.g., a Developer pairing with a Product Designer, QA, or UI/UX engineer) to bridge the gap between design, testing, and implementation.

> [!NOTE]
> Pairing on a single feature is good, but rotating pairs across multiple features (Promiscuous Pairing) is better. The big issue with static pairs is the **lack of shared context**. Rotating developers ensures that knowledge of the codebase spreads across the entire team, preventing knowledge silos and single points of failure.

## Techniques to Try
* **Driver and Navigator:** The standard setup. The **Driver** controls the keyboard and focuses on the micro (syntax, typing, immediate logic). The **Navigator** observes, focuses on the macro (architecture, spotting bugs, thinking about the next test), and guides the direction.
* **Ping Pong:** Heavily tied to Test-Driven Development (TDD). Developer A writes a failing test (Red). Developer B takes the keyboard, writes the code to pass it (Green), and then writes the next failing test (Red) before passing the keyboard back. Keeps both devs highly engaged.
* **Tour Guide:** A variation of Driver/Navigator usually meant for onboarding or domain exploration. The Navigator (a senior dev or domain expert) acts as a "tour guide," explicitly guiding the Driver (a junior dev or someone new to the codebase) step-by-step through a complex system.
* **Pomodoro:** Time-based pairing. Short, intense bursts of work (e.g., 25 minutes of focused pairing followed by a 5-minute break). You layer this timing method on top of another technique (like Ping Pong) to prevent mental fatigue.
* **Task List:** Pairing guided by a highly specific checklist of subtasks. Instead of swapping based on an arbitrary timer, developers swap roles every time a specific subtask or test is completed.

> [!NOTE]
> The best process is the process that works for your team!
> The best technique is the one that works for you and your pair. Communicate early and often about what is and isn't working.

# User Stories

> [!NOTE]
> Basically this serves as a way to focus on what ACTUALLY produces value.
> From the Lean Start Up it's used to focus developer time (the most precious resource),
> It's no longer a question of can it be built, it's a question of SHOULD IT BE BUILT.
> It's like TDD for the meta-view of features.

* Used to narrow and determine what actually needs to be accomplished.

* Technical Stories
* Chores: Task that are necessary, but provide no direct or obvious value to the user (e.g., logging, authentication)
  * Spikes: area of technical investigation, not sure how we're going to implement it, but we're going to play with it. **Feature-find** (similar to Blue-Green testing)

* **Bugs**
  * Where found
  * How found
  * What was the expected behavior
  * What I observed
  * Can you reproduce it/verifiable

## Gherkin Modeling
* [Gherkin Modeling](https://medium.com/@nic/writing-user-stories-with-gherkin-dda63461b1d2)

* User Story (Why we are building the thing??)
  * The Why - user action
  * As a "user/persona" - persona name
  * I want "action" - to accomplish a task using this product/soltion
  * So that "outcome" - something about the users life outside the product/solution changes for the better.

* Acceptance Criteria (The How and Acceptance Criteria):
  * **Given** (how things begin)
  * **When** (action taken)
  * **Then** (outcome of taking action)
  * **And** (can be used at any stage to ensure that you are building and designing the right feature)**

* The who, what, and why of a feature. Intentionality of your choices!

### Instrumentation
* What is the thing that we are trying to implement SO THAT we learn if its  being used in teh way we assume?
  * Here we link to design files
  * Decisions the team has made related to the story
  * Outstanding questions that team needs to answer
  * Anything else the team finds noteworthy

> [!NOTE]
> Don't immediately look to build a software solution when a simple process update is much more efficient!

# Balanced Team

* A balanced team typically comprises includes a product manager (PM), designer, developer, and platform engineer (PE). Each provide different perspectives and contribute to the idea of a balanced and dynamic team.
* The caveat here is that each role can be adopted/inherited by other roles, for example, a Platform Engineer is able to also assume PM duties in the event that the original PM is away or is unable to make a application decision.
* There's another idea/heuristic of using **desire (designer)**, **technical feasibility (PE and developer)**, and **viability (PM)** to address specific aspects of the balanced team.
* All aspects of the balanced team should work in tandem (e.g., Venn diagram )

## Designers
* Focus on the UI/UX of the thing that you are building, the emphasis here is on the end user via user centered design (UCD) (identification of direct pain points that the user may face).
* The goal of the designer is to hold the individual sacrosanct in the development process and ensure that the features that are being added discrete value to the end user above all else.

## PMs
* Focus on the direction and larger picture of the application/product, their job is to see "the forest from the trees" and provide direction for the project.
* The interact and are the direct touch point between the stakeholder, customer, and the balanced team.
* They are the internal advocates for the team and work with external environment to safegaurd the team from excessive bureaucracy that adds unnecessary complexity to the development environment.

## Devs
* Sanity check, provide feasibility and technical ability and feasibility.
* How to extract the essence and basics of implementation.
* Identify the need for more technical research.

# Standup Basic Elements

## "3" Qs
* What did I do yesterday?
* What am I doing today?
* What blockers do I have?

## Reviewing as Pairs
* What did the pair accomplish yesterday?
* What blockers did the pair have?
* What is the pair planning to do today?

# Estimating 

# Discovery and Framing

1. Problems
2. Prioritize
3. Solutions
4. Prioritize