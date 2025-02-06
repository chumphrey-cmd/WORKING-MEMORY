# AI-assisted Coding: Power User Playbook


- [AI-assisted Coding: Power User Playbook](#ai-assisted-coding-power-user-playbook)
  - [Problem Solving Framework](#problem-solving-framework)
    - [1. Understand (Decompose) the Problem](#1-understand-decompose-the-problem)
    - [2. Devise/Carry Out the Plan](#2-devisecarry-out-the-plan)
    - [3. Examine the Solution Obtained](#3-examine-the-solution-obtained)
    - [4. Refine and Document](#4-refine-and-document)
  - [Phase 1: Understand and Decompose the Problem](#phase-1-understand-and-decompose-the-problem)
    - [1.1 Set Up Your AI Environment](#11-set-up-your-ai-environment)
    - [1.2 Define Your Task](#12-define-your-task)
    - [1.3 Break Down Complex Tasks](#13-break-down-complex-tasks)
    - [1.4 Initial High-Level Planning (Using a Reasoning Model)](#14-initial-high-level-planning-using-a-reasoning-model)
  - [Phase 2: Devise/Carry Out the Plan](#phase-2-devisecarry-out-the-plan)
    - [2.1 Set Up the Implementation Plan](#21-set-up-the-implementation-plan)
    - [2.2 Implement in Phases](#22-implement-in-phases)
    - [2.3 Track Progress](#23-track-progress)
    - [2.4 Code Review and Testing](#24-code-review-and-testing)
    - [2.5 Iterate and Repeat](#25-iterate-and-repeat)
    - [2.6 Document Your Code](#26-document-your-code)
  - [Phase 3: Examine the Solution Obtained](#phase-3-examine-the-solution-obtained)
    - [3.1 Combine Codebase](#31-combine-codebase)
    - [3.2 Feature Implementation](#32-feature-implementation)
    - [3.3 Iterate on Implementation](#33-iterate-on-implementation)
  - [Phase 4: Refine and Document](#phase-4-refine-and-document)
    - [4.1 Review and Understand](#41-review-and-understand)
    - [4.2 Prompt Engineering](#42-prompt-engineering)
    - [4.3 Database and Schemas](#43-database-and-schemas)
    - [4.4 One Task per Session](#44-one-task-per-session)
    - [4.5 Exploit Full Code Generation](#45-exploit-full-code-generation)
  - [Hints, Tips, and Tricks](#hints-tips-and-tricks)
    - [1. Leverage Step-by-Step Thinking](#1-leverage-step-by-step-thinking)
    - [2. Set Up a Persistent AI Project Space](#2-set-up-a-persistent-ai-project-space)
    - [3. Work Around Framework Limitations](#3-work-around-framework-limitations)
    - [4. Focus on One Task per Session](#4-focus-on-one-task-per-session)
    - [5. Write Clear and Specific Prompts](#5-write-clear-and-specific-prompts)
    - [6. Break Down Complex Tasks](#6-break-down-complex-tasks)
    - [7. Annotate Code with Comments](#7-annotate-code-with-comments)
    - [8. Use AI for Code Reviews](#8-use-ai-for-code-reviews)
    - [9. Generate Documentation](#9-generate-documentation)
    - [10. Automate Database and Query Tasks](#10-automate-database-and-query-tasks)
    - [11. Take Responsibility for Your Code](#11-take-responsibility-for-your-code)
    - [12. Combine and Organize Your Codebase](#12-combine-and-organize-your-codebase)


---


## Problem Solving Framework

### 1. Understand (Decompose) the Problem
- Clearly define the problem you're solving—break it down into discrete, actionable components. 
- Invest time upfront in fully understanding the problem, as this will save effort later and streamline the development process.


### 2. Devise/Carry Out the Plan
- Identify the connection between the input data and the desired outcome.
- Once the problem is clearly defined, start developing pseudo-code or step-by-step procedures to address it programmatically at each phase.
- Begin implementing the pseudo-code incrementally. **Take your time** — understand why the model is proposing specific solutions. 
- If you don’t understand something, **ask the model for clarification** to deepen your understanding.


### 3. Examine the Solution Obtained
- Validate the solutions at each step, ensuring they are reproducible and that you fully understand their output.
- Testing and debugging should be integral parts of this phase to confirm the solution aligns with the problem requirements.


### 4. Refine and Document
- Once your project is functioning as intended, review it thoroughly to ensure you understand each component.
- Prioritize clear documentation, as it is crucial for maintaining, scaling, or revisiting the project in the future. 
- Reflect on what you've learned and ensure clarity in both your code and the associated documentation.


---


## Phase 1: Understand and Decompose the Problem

### 1.1 Set Up Your AI Environment
   - Create a dedicated workspace in a tool like Claude or a custom GPT instance.
   - Provide a foundational explanation of your codebase, covering key aspects such as:
     - Dependencies
     - Deployment requirements
     - File structure
   - This upfront context saves time and ensures more precise AI-generated responses.


### 1.2 Define Your Task
   - Craft clear, specific prompts to guide the AI effectively.
   - Include essential details such as:
     - Input/output types
     - Error-handling expectations
     - UI behavior or user interactions (if applicable)
   - Approach prompt writing as though you’re explaining the task to another developer, prioritizing clarity and precision.


### 1.3 Break Down Complex Tasks
   - Divide the overall problem into smaller, manageable components.
   - Breaking tasks into steps will help you:
     - Stay organized
     - Approach coding logically
     - Simplify debugging and testing


### 1.4 Initial High-Level Planning (Using a Reasoning Model)
   - Leverage a large-context reasoning model to create an overarching plan for the project.
   - Collaborate with the model to:
     - Choose the appropriate tech stack
     - Design the app or solution’s structure
   - Instruct the model to generate a detailed implementation roadmap (e.g., an `IMPLEMENTATION.md` file) to guide development.
   - Review the plan thoroughly, ensuring you understand the rationale behind its suggestions.

**NOTE:** The more complex the project, the more critical it is to stay organized. 
- A comprehensive and detailed `IMPLEMENTATION.md` file—or an equivalent tracking system—will is ESSENTIAL for tracking progress and preventing confusion. 

---


## Phase 2: Devise/Carry Out the Plan

### 2.1 Set Up the Implementation Plan 
   - Create an `IMPLEMENTATION.md` file and paste the implementation plan from the reasoning model.  
   - Open a coding environment (e.g., VS Code) in your project directory to begin working.  



### 2.2 Implement in Phases  
   - Start with Phase 1 of your implementation plan.  
   - Collaborate with the model (e.g., Claude or GPT) to carefully review the plan and begin implementing the code.  


### 2.3 Track Progress  
   - Once a phase is completed, update your `IMPLEMENTATION.md` file as necessary to reflect completed steps and any changes.  
   - Maintain clear records of what has been achieved to avoid confusion in subsequent phases.  


### 2.4 Code Review and Testing  
   - Conduct a code review with the AI. Use targeted prompts like:  
     - "Does this approach align with best practices?"  
     - "Are there any areas where this logic could break or be optimized?"  
   - Test the implemented functionality thoroughly.  
   - Debug any issues collaboratively with the AI.  


### 2.5 Iterate and Repeat  
   - After completing a phase, start a new chat or session with the AI to proceed with the next phase.  
   - Review the `IMPLEMENTATION.md` and progress markdown files before continuing.  
   - Repeat the implementation, review, test, and progress tracking steps for all phases until the initial implementation is fully complete.  


### 2.6 Document Your Code  
   - Request the AI to add detailed comments within the code that explain its logic, assumptions, and functionality.  
   - Generate supplementary documentation such as:  
     - A README file with project details.  
     - API documentation or user guides, if applicable.  

---

## Phase 3: Examine the Solution Obtained

### 3.1 Combine Codebase  
   - Merge your code into a single, cohesive file or repository.  
   - Ensure all dependencies are properly linked, and the codebase is ready for comprehensive testing.  


### 3.2 Feature Implementation  
   - Return to the reasoning model and select a specific feature to implement fully.  
   - Request a detailed implementation plan for the selected feature from the model.  
   - Update the `IMPLEMENTATION.md` file with the new plan and clear the `PROGRESS.md` file to reflect a clean slate for tracking this feature’s progress.  


### 3.3 Iterate on Implementation  
   - Work collaboratively with the AI to implement the feature in manageable phases, focusing on specific tasks or components.  
   - After each phase:  
     - Update the `PROGRESS.md` file with completed tasks and notes.  
     - Test the feature to ensure it functions as intended and aligns with project requirements.  
   - Repeat this iterative process for each additional feature until the solution is complete and functional.  

---



## Phase 4: Refine and Document 

### 4.1 Review and Understand 
   - Take full responsibility for your app by thoroughly understanding the code provided by the AI.  
   - Read any associated documentation or ask the AI for clarifications to fill gaps in understanding.  


### 4.2 Prompt Engineering  
   - Use specialized AI tools or other language models (LLMs) to generate and refine effective prompts for handling complex tasks or scenarios.  
   - Experiment with different phrasing to optimize the quality of AI-generated outputs.  


### 4.3 Database and Schemas 
   - Leverage AI to draft database queries and schemas, especially for complex databases where errors can be costly.  
   - Validate AI-generated queries with test cases to ensure correctness.  


### 4.4 One Task per Session
   - Limit each AI interaction session to a single task to maintain clarity and prevent context contamination.  
   - Start a new session for each problem or task once the current one is resolved.  


### 4.5 Exploit Full Code Generation 
   - Use the "give full code" functionality whenever feasible to generate complete, ready-to-use solutions.  
   - Minimize manual editing by requesting end-to-end code outputs for complex modules or workflows.  


---



## Hints, Tips, and Tricks  

### 1. Leverage Step-by-Step Thinking  
For creative tasks like designing code architecture, use a "chain of thought" approach. Add "Think step-by-step" to your prompt to encourage a detailed analysis of the problem.  

---

### 2. Set Up a Persistent AI Project Space  
Create a project in a tool like Claude or a custom GPT environment where you can provide a basic explanation of your codebase, including:  
- Dependencies  
- Deployment details  
- File structure  

This saves time on repetitive explanations and helps the AI give more accurate responses.  

---

### 3. Work Around Framework Limitations  
If the AI lacks knowledge about the latest versions of frameworks or plugins:  
- Copy-paste the relevant documentation or specifications directly into the session.  
- Ask the AI to generate code based on the latest spec.  

---

### 4. Focus on One Task per Session  
Avoid cluttering the AI’s context by sticking to one task per session. Once a task is completed, start a new session. This approach:  
- Maintains high-quality responses.  
- Allows you to effectively use "give full code" for cohesive results with minimal manual edits.  

---

### 5. Write Clear and Specific Prompts  
Treat your prompt like explaining a task to a colleague. Include details like:  
- Desired functionality  
- Input/output types  
- Error handling requirements  
- UI behavior  

If your problem is complex, use another LLM to generate effective prompts. For example:  
- “Generate a comprehensive and effective prompt that **you**, as an LLM, would understand to solve the following problem…”  

---

### 6. Break Down Complex Tasks  
Instead of tackling an entire system at once, divide it into smaller, manageable components. For complex projects:  
- Ask the reasoning model to generate a high-level framework, such as an `IMPLEMENTATION.md` file, outlining steps, phases, or pseudocode.  
- Use this framework to guide your development process.  

---

### 7. Annotate Code with Comments  
Request the AI to include detailed comments explaining the logic behind the generated code. This helps you and the AI understand the code better, especially for future modifications.  

---

### 8. Use AI for Code Reviews  
Prompt the AI to review generated code for potential improvements. Even a simple “Are you sure?” can force it to double-check its work and refine the solution.  

---

### 9. Generate Documentation  
Go beyond inline comments by asking the AI to create comprehensive documentation, such as:  
- README files  
- API documentation  
- User guides  

This step will save you time and effort when onboarding new developers or revisiting the project later.  

---

### 10. Automate Database and Query Tasks 
Let AI handle the dull but error-prone tasks like:  
- Generating database schemas  
- Writing SQL queries  
- Crafting regex patterns  

Always validate the output with test cases to ensure correctness.  

---

### 11. Take Responsibility for Your Code  
Understand every piece of code you use. Remember: **YOU** are responsible for your app, not the AI. If something is unclear:  
- Read the documentation.  
- Use the AI to clarify any uncertainties.  

---

### 12. Combine and Organize Your Codebase  
Combine your codebase into a single, organized file using tools like [gptree](https://github.com/travisvn/gptree).  
- **NOTE:** for my use case, I needed to pip install via WSL2.
- Use the reasoning model to identify which feature or component to implement first.  
- Instruct the AI to examine your codebase and generate a comprehensive phased plan.  
- Update your progress files (`IMPLEMENTATION.md` and `PROGRESS.md`) as needed.  
