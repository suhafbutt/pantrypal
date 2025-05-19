# 🍳 PantryPal - Smart Recipe Finder

**PantryPal** is a Ruby on Rails web application that helps users find relevant recipes based on the ingredients they already have at home. Users can search for recipes by including or excluding ingredients, and further refine results using filters like prep time, cook time, and ratings.

---

## 🚀 Features

- Ingredient-based recipe search
- Exclude ingredients from results
- Filters: prep time, cook time, rating

---

## 🧪 User Stories

### User Story 1: Basic Ingredient Search

**As a** home cook,  
**I want to** search for recipes using ingredients I already have,  
**So that** I can cook something without needing to buy more items.

*Acceptance Criteria*:
- Enter a list of ingredients
- See matching recipes with title, image, and rating

---

### User Story 2: Exclude Unwanted Ingredients

**As a** user with dietary restrictions,  
**I want to** exclude certain ingredients from search results,  
**So that** I only see recipes I can safely prepare.

*Acceptance Criteria*:
- Provide a list of ingredients to exclude
- See only recipes that do not contain those ingredients

---

### User Story 3: Filter by Prep and Cook Time

**As a** busy professional,  
**I want to** filter recipes by prep and cook time,  
**So that** I can quickly find recipes that fit within my schedule.

*Acceptance Criteria*:
- Set maximum prep/cook time values
- Get recipes within those time limits

---

## ⚙️ Setup Instructions

**Clone the repository, run command in terminal tosetup database and run server**

```bash
git clone https://github.com/your-username/pantrypal.git
cd pantrypal

rake db:create
rake db:migrate
rake db:seed

bundle install

rails s