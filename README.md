<div align="center">

# 🏏 ProMatch Arena
### Cricket Tournament Management System

A full-stack, enterprise-style platform to manage cricket tournaments, teams, squads, matches, payments and live points tables.

![Java](https://img.shields.io/badge/Java-17+-orange?logo=openjdk&logoColor=white)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.x-6DB33F?logo=springboot&logoColor=white)
![Spring Security](https://img.shields.io/badge/Spring%20Security-RBAC-6DB33F?logo=springsecurity&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Database-336791?logo=postgresql&logoColor=white)
![Razorpay](https://img.shields.io/badge/Razorpay-Payments-0C2451?logo=razorpay&logoColor=white)
![Brevo](https://img.shields.io/badge/Brevo-Email%20OTP-0B996E)
![Bootstrap](https://img.shields.io/badge/Bootstrap-5-7952B3?logo=bootstrap&logoColor=white)
![Maven](https://img.shields.io/badge/Build-Maven-C71A36?logo=apachemaven&logoColor=white)

[🔗 Live Demo](https://cricket-tournament-43i3.onrender.com) • [✨ Features](#-key-features) • [🛠️ Tech Stack](#️-tech-stack) • [🚀 Getting Started](#-getting-started)

</div>

---

## 📑 Table of Contents
- [Live Demo](#-live-demo)
- [Screenshots](#-screenshots)
- [Key Features](#-key-features)
- [Tech Stack](#️-tech-stack)
- [Application Workflow](#-application-workflow)
- [Project Structure](#-project-structure)
- [Environment Variables](#-environment-variables)
- [Getting Started](#-getting-started)
- [Future Scope](#-future-scope)
- [Author](#-author)

---

## 🔗 Live Demo

- **Live Application:** [https://cricket-tournament-43i3.onrender.com]
- **Demo Admin Login:** `your-admin-email` / `your-password`
- **Demo User Login:** `your-user-email` / `your-password`

> Note: The app is hosted on a free tier, so the first load may take a few seconds.

---

## 📸 Screenshots

| Home (Dark) | Home (Light) |
|---|---|
| ![Home Dark](screenshots/home-dark.png) | ![Home Light](screenshots/home-light.png) |

| Admin Panel | Points Table |
|---|---|
| ![Admin](screenshots/admin.png) | ![Points](screenshots/points-table.png) |

| Payment (Razorpay) | Mobile View |
|---|---|
| ![Payment](screenshots/payment.png) | ![Mobile](screenshots/mobile.png) |

---

## ✨ Key Features

### 🏆 Tournaments & Matches
- Create and manage multiple tournaments with schedules and fixtures.
- Team and player registry with full CRUD, jersey numbers and live search.
- Squad rules: minimum 11 and maximum 15 players per team.
- **Automatic Net Run Rate (NRR)** calculation and live **Points Table** after every approved result.

### 💳 Razorpay Payments
- Team registration fee of **₹500** through Razorpay secure checkout.
- Server-side payment verification before a team is confirmed.
- Clear flow: Register Team ➔ Pay ₹500 ➔ Admin Verifies ➔ Team Confirmed.

### 🔐 Security & Authentication
- Role-based access control (**ADMIN** and **USER**) using Spring Security.
- Secure login, registration and in-app password change.
- **Email OTP password recovery** (`forgot_password`, `verify_otp`, `reset_password`) powered by the **Brevo API**.
- Session protection and input sanitization.

### 🛠️ Admin Panel
- Dedicated Tournament Command Center for tournaments, teams, matches and approvals.
- Approve or reject team registrations and verify payments.

### 🎨 Modern & Responsive UI
- Cyber Glassmorphism design with a **persistent Dark / Light theme** (saved in `localStorage`).
- **Fully mobile responsive** on phones, tablets and desktops.
- Extra pages: About, Rules & Regulations, FAQ & Support Center and an in-app **Chatbot**.

---

## 🛠️ Tech Stack

| Layer | Technologies |
|---|---|
| **Backend** | Java, Spring Boot, Spring MVC, Spring Security, Spring Data JPA, Hibernate |
| **Database** | PostgreSQL (Cloud-hosted via Neon DB) |
| **Frontend** | JSP (Jakarta Server Pages), JSTL, HTML5, CSS3, JavaScript, Bootstrap 5 |
| **Payments** | Razorpay |
| **Email / OTP** | Brevo API |
| **Build Tool** | Maven |
| **Deployment** | Render |

---

## 🔄 Application Workflow

```text
Register / Login  ➔  Register Team + Add Squad  ➔  Pay ₹500 (Razorpay)
        ➔  Admin Verifies & Approves  ➔  Matches Played & Results Approved
        ➔  Points Table + NRR Update Automatically
```

1. **Register / Login** with role assignment (ADMIN or USER).
2. **Register your team** and add squad members.
3. **Pay ₹500** registration fee through Razorpay.
4. **Admin verifies** the payment and approves the team.
5. **Matches are played**, results are approved and the **Points Table + NRR** update automatically.

---

## 📁 Project Structure

```text
Cricket_Tournament/
├── src/main/java/Cricket_Tournament/
│   ├── Cricket_TournamentController/    # Web controllers (user, match, team, tournament, payment)
│   ├── Cricket_TournamentEntity/        # JPA entities (database models)
│   ├── Cricket_TournamentRepository/    # Spring Data JPA repositories
│   └── Cricket_TournamentService/       # Business logic and services
├── src/main/webapp/WEB-INF/views/       # JSP views (Home, Login, Register, Admin panels, Points table)
├── src/main/resources/                  # application.properties and static assets
├── screenshots/                         # README screenshots
└── pom.xml                              # Maven configuration and dependencies
```

---

## 🔐 Environment Variables

Set these before running the app. **Never commit real keys to GitHub.**

| Variable | Description |
|---|---|
| `SPRING_DATASOURCE_URL` | PostgreSQL connection URL (e.g. `jdbc:postgresql://localhost:5432/cricket_db`) |
| `SPRING_DATASOURCE_USERNAME` | Database username |
| `SPRING_DATASOURCE_PASSWORD` | Database password |
| `RAZORPAY_KEY_ID` | Razorpay Key ID (use **test mode** keys locally) |
| `RAZORPAY_KEY_SECRET` | Razorpay Key Secret |
| `BREVO_API_KEY` | Brevo API key for sending OTP emails |
| `BREVO_SENDER_EMAIL` | Verified sender email in Brevo |

> Tip: Keep real values in a local `application.properties` (added to `.gitignore`) and commit only an `application-example.properties` with placeholders.

---

## 🚀 Getting Started

### Prerequisites
- JDK 17 or higher
- Maven 3.8+
- PostgreSQL
- Razorpay account (test mode) and Brevo account

### Installation

**1. Clone the repository**
```bash
git clone https://github.com/jitendrasinghsalmo/your-cricket-tournament-repo.git
cd Cricket_Tournament
```

**2. Create the database**
```sql
CREATE DATABASE cricket_db;
```

**3. Configure properties**

Update `src/main/resources/application.properties` (or set the environment variables above) with your database, Razorpay and Brevo details.

**4. Run the application**
```bash
mvn spring-boot:run
```

**5. Open in browser**
```text
http://localhost:8080
```

---

## 🧭 Future Scope

- Live ball-by-ball scoring with WebSockets
- Native Android / iOS companion app
- AI-based match insights and player form prediction
- Multi-sport support (football, kabaddi, volleyball)

---

## 👨‍💻 Author

**Jitendra Singh**
Java Full Stack Developer | Bengaluru, India

- GitHub: [jitendrasinghsalmo](https://github.com/jitendrasinghsalmo)
- LinkedIn: [Jitendra Singh](https://linkedin.com/in/jitendra-singh-725698290)

---

<div align="center">

⭐ If you like this project, please give it a star on GitHub!

</div>
