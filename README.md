# Personal Finance Management App

## Introduction
This is a Flutter-based application designed to help users track their income, expenses, and overall financial health. The app provides intuitive financial insights and an easy-to-use interface for better money management.

## Features
- Add, edit, and delete income and expense transactions.
- Categorize transactions by predefined or custom categories.
- View detailed financial reports (daily, monthly, yearly).
- Interactive charts for financial analysis.
- 
## Technologies Used
- **Flutter** (latest version)
- **State Management**: MVVM architecture (Provider/Riverpod/Bloc)
- **Database**: SQLite, Hive, or Firebase Firestore
- **AI & OCR**: Google ML Kit, Tesseract for receipt recognition

## Installation & Setup
Ensure you have Flutter SDK installed before proceeding.

### Steps to Run the App:
```sh
# Clone the repository
git clone <repo_url>
cd <project_folder>

# Install dependencies
flutter pub get

# Run the application
flutter run
```

## Project Structure
```
lib/
|-- constant/      
|-- models/    
|-- pages
|-- providers/   
|-- utils
|-- widgets  
```

## Một số giao diện của ứng dụng
### Home Screen
![Image](https://private-user-images.githubusercontent.com/115705231/424798622-12d95a73-18f2-4309-b364-43884af8a818.jpg?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDI0MzkxOTIsIm5iZiI6MTc0MjQzODg5MiwicGF0aCI6Ii8xMTU3MDUyMzEvNDI0Nzk4NjIyLTEyZDk1YTczLTE4ZjItNDMwOS1iMzY0LTQzODg0YWY4YTgxOC5qcGc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMzIwJTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDMyMFQwMjQ4MTJaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1lZjI3NzAzYTFlNTVjOTExMDE4ZjM5NDk3ZDFhNmQ0ZDQyYTJlOTM4NGU4MTJjYmU5Y2JiZGQwNGRmOGI5ZmNlJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.NevWF4c6hrQWGNQaDrWiVY82fYLodUqyOH8vtclS2MU)
### Transaction History
![Image](https://private-user-images.githubusercontent.com/115705231/424798203-b5aa6586-c240-4cfb-a816-99f931e0b7df.jpg?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDI0MzkxOTIsIm5iZiI6MTc0MjQzODg5MiwicGF0aCI6Ii8xMTU3MDUyMzEvNDI0Nzk4MjAzLWI1YWE2NTg2LWMyNDAtNGNmYi1hODE2LTk5ZjkzMWUwYjdkZi5qcGc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMzIwJTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDMyMFQwMjQ4MTJaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1hN2ViODNiNjQ4ZDAxNGI0NWNkYzFjZDBmMmI1MjJhZmQ4NzA5MzU5NDdhOWFhOTBiM2Q2YjhiNTRhOGZkMWQxJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.NFSiXst6-MpPIM4qj9eQwPIU81fwUl5ILn76FqemmD4)
### Add Expense
![Image](https://private-user-images.githubusercontent.com/115705231/424798439-82202f3a-7426-4f94-8f5c-9208e219c449.jpg?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDI0MzkxOTIsIm5iZiI6MTc0MjQzODg5MiwicGF0aCI6Ii8xMTU3MDUyMzEvNDI0Nzk4NDM5LTgyMjAyZjNhLTc0MjYtNGY5NC04ZjVjLTkyMDhlMjE5YzQ0OS5qcGc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMzIwJTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDMyMFQwMjQ4MTJaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1iZDJkZDM5NjNhYzcyODQ3Y2MzMzk2OWI4MGM0NjExYTE5M2NlZDZmODFjNjQ1MWQzY2ZlMGIxYjNjNDQzZmIxJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.aJMcso5MGfajprnABpZTfzSeC6hHOUGXMCQCvuBxXhs)
### Expense Limit Details
![Image](https://private-user-images.githubusercontent.com/115705231/424798501-70bb2ca9-24bb-448c-810c-50a2f1257364.jpg?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDI0Mzk0MzUsIm5iZiI6MTc0MjQzOTEzNSwicGF0aCI6Ii8xMTU3MDUyMzEvNDI0Nzk4NTAxLTcwYmIyY2E5LTI0YmItNDQ4Yy04MTBjLTUwYTJmMTI1NzM2NC5qcGc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMzIwJTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDMyMFQwMjUyMTVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1iNzNhODAxNGVlNGY1NjIzNGI1YWUxOWYwYWU4YzJiM2Y4MWMzZGQ5YTY5N2RhMDBmMGE5Mjg0YTM1OTViM2U4JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.9dY4Qp3USRbY5odqt_8lVTcWcwBKRFvIc6Q2PykbcpQ)

## Contribution & Development
We welcome contributions! To contribute:
1. Fork the repository.
2. Create a new branch.
3. Make changes and commit them.
4. Submit a pull request.

## Contact
For any questions or issues, feel free to reach out:
- **Email**: [nguyenxuandinh336@gmail.com]
- **GitHub**: [https://github.com/nxdinh94]

