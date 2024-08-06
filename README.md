<div style="text-align: center;">
    <h1>DiveBuddy</h1>
</div>

Manage and customize your diving gear sets with ease for various conditions and seasons.

## Table of Contents
- [Use cases](#use-cases)
- [Tech Stacks](#tech-stacks)
- [Database Design](#database-design)
  - [Features of Firebase Realtime Database](#features-of-firebase-realtime-database)
  - [Database Design](#database-design)

## Use cases

- Authentication
  - A user can sign up with email/password or third-party services such as Google.
  - A user can log in with email/password or third-party services such as Google.
- Kits
  - A user can see lists of kits. (emoji, color, kit name, num of gears)
  - A user can mark a gear on a list. (gear image, gear name, isChecked)
  - A user can see and edit details of a kit. (emoji, color, kit name, gear image, gear name)
  - A user can delete a kit.
- Gears
  - A user can see lists of gears. (gear image, gear name)
  - A user can see and edit details of a gear. (gear image, gear name, brand, currency, price, purchase date, maintenance history)
  - A user can delete details of a gear. 
  - A user can see and edit details of a maintenance history.
  - A user can delete a maintenance history.
- Settings
  - A user can see settings of this app.

## Tech Stacks

| Name                       | Purpose of Use           | Why I chose?                                                                                                                                                                             |
| -------------------------- | ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Firebase Authentication    | Authenticate users. | xx                                                                                                                                                                                       |
| Firebase Realtime Database | Save data.          |- I don't need to develop server-side app by using this BaaS. <br> - This app is going to have chat feature in the future and real time synchronization of data is gonna be important. <br> - Accessing data when offline is important for user experience. |
| Cloud Storage              | Save image data.    | xx                                                                                                                                                                                       |
|Firebase Analytics|Analyze user behavior|xx|

## Database Design

### Features of Firebase Realtime Database

- Firebase Realtime Database is NonSQL
  - Schemaless
    - But can have security rules like constraints in case of SQL
  - Data structure should be flat (called denormalize)


### Database Design

- Used JSON to design. Tried not to use normal ER diagrams to avoid stick to the SQL concept because I'm more familiar with SQL than NonSQL.

```json
{
  "User": {
    "userID1": {
      "kits": {
        "kitID1": true,
        "kitID3": true
      },
      "gears": {
        "gearID1": true,
        "gearID4": true,
        "gearID5": true
      }
    }
  },
  "Kit": {
    "kitID1": {
      "userID": "userID1",
      "name": "Summer Diving",
      "color": "blue",
      "emoji": "😎",
      "gears": {
        "gearID1": true,
        "gearID2": true
      },
      "gearCheckList": {
        "gearID1": true,
        "gearID2": false
      },
      "_updatedAt": 1234566,
      "_createdAt": 1234566
    }
  },
  "Gear": {
    "gearID1": {
      "userID": "userID1",
      "name": "Dry Suit",
      "brandName": "Aqualung",
      "price": 500,
      "purchaseDate": 123455,
      "maintenances": {
        "maintenanceID1": true,
        "maintenanceID2": true
      },
      "_updatedAt": 1234566,
      "_createdAt": 1234566 
    }
  },
  "Maintenance": {
    "maintenanceID1": {
      "gearID": "gearID1",
      "date": 1234566,
      "details": "Cleaning",
      "price": 50,
      "note": "Replaced small parts",
      "_updatedAt": 1234566,
      "_createdAt": 1234566
    },
  }
}
```