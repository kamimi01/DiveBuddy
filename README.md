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
    "Kit": {
        "uZD0SSrDgFSejfl8KIn0dho1snF3": {
            "kitID1": {
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
            },
            "kitID3": {
                "name": "Summer Diving",
                "color": "blue",
                "emoji": "🤿",
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
        "RK9xBXlQTBR8YZja6KcWYid5sFf1": {
            "kitID2": {
                "name": "Winter Diving",
                "color": "blue",
                "emoji": "🤿",
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
        }
    },
    "Gear": {
        "uZD0SSrDgFSejfl8KIn0dho1snF3": {
            "gearID1": {
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
            },
            "gearID2": {
                "name": "Light",
                "brandName": "TUSA",
                "price": 600,
                "purchaseDate": 123455,
                "maintenances": {
                    "maintenanceID3": true
                },
                "_updatedAt": 1234566,
                "_createdAt": 1234566
            }
        }
    },
    "Maintenance": {
        "gearID1": {
            "maintenanceID1": {
                "date": 1234566,
                "details": "Cleaning",
                "price": 50,
                "note": "Replaced small parts",
                "_updatedAt": 1234566,
                "_createdAt": 1234566
            },
            "maintenanceID2": {
                "date": 1234566,
                "details": "Repair",
                "price": 50,
                "note": "Replaced small parts",
                "_updatedAt": 1234566,
                "_createdAt": 1234566
            }
        },
        "gearID2": {
            "maintenanceID3": {
                "date": 1234566,
                "details": "Repair2",
                "price": 50,
                "note": "Replaced small parts",
                "_updatedAt": 1234566,
                "_createdAt": 1234566
            }
        }
    }
}
```