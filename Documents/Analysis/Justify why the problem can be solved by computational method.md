# Justify why the problem can be solved by computational methods

- DO's
    - [x]  Explain why the problem is suited to a computer program
    - [x]  Explain the features of your problem that are amenable to a programmed solution
    - [x]  Explain why the output from the solution is valuable to the stakeholders(users)

- DON'Ts
    - Simply state that you are going to create a program because it is needed. You must justify decisions.

---

- ISSAC - Describe and justify the features that make the problem solvable by computational methods
    - It is important to define the problem clearly so that you, your client, and anyone else who reads the project report has a clear understanding of what is being addressed. You must assume that the reader knows nothing about the problem or area that you are investigating.
    - Not all problems require a computerised solution. Some problems would be solved through more efficient manual processes, and some problems do not require solutions at all. Remember that, in the real world, no new system would be approved unless there were quantifiable benefits to an organisation or user.

---

- OCR Criteria
    - Described and justified the **features** that make the problem solvable by **computational methods**, explaining why it is amenable to a computational approach.
- Draft Bullet Points
    - Using an mobile phone to track your diet is convenient and efficiently
        - You don't need to bring a journal to track the diet everyday.
    - This app need a iPhone to run, as it is written in swift
    - This app

Before the creation of diet tracking app, people can only record their meal by writing notes and diaries. It is not convenient as they have to brought a notebook with them all the time, and remembering all the nutrition information for every type of food is too hard for human-being. 

Hence, an mobile app with up-to-date nutrition database is a efficient and convenient solution to this problem. As the computer can store and calculate large amount of nutrition data in a very short time. Also it can analysis the data and provides user with statistical graphs to make the boring number more appealing for user to understand.

### Problem Recognition

The main problem is building an diet tracking app that can attract users to keep using it by recommending dishes based on their consuming history and visualize statistical healthy data to show user their current health information also providing interaction between users to let them engaged in this healthy diet society. In other words, creates an database on a server that save a variety of information of different kinds of foods and held user information; creates an algorithm that is able to automatically recommend optimal dishes to user based on their consumption history stored in the database and their location or other personal information; creates an online community among users.

### Problem Decomposition

Each part of this problem can be decomposed into a set of smaller steps.

- **Tracking Diet**:
    1. User select what food they had eat in that meal from the food information database.
    2. The app calculate the amount of nutrition the user had taken in.
    3. The app save the record to user's database, and visualize the numbers in statistical graphs to user.
- **Recommending Meals**:
    1. The app reads the user persona profile from user's database.
    2. The app using an algorithm to analysis the persona profile, and the amount of nutrition the user had taken in within a few days.
    3. The app then gives user recommendation of foods that they might like and will fit their healthy diet.
- **Interactive Community**:
    1. Users can leave comments on foods in the food description.
    2. The comments will be saved in the online database.
    3. Users can add each other's account to becomes "friends"
    4. The app will provide an ranking among friends, to let users see how their friends has contribute to healthy diet.

By broken down the whole complex problem into these subroutines, it reduce the complexity of the program.

### Divide and Conquer

Each small part of these problems can be solved on their own and combined together into a modular program, like database module, online communication module, hence make use of the divide and conquer method of problem solving. This will greatly simplifies very complex problems.

### Abstraction

Using levels of abstraction allows splitting the complex problem and its functionality to simpler components part.

— ADD THIS MORE —