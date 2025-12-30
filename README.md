
# Aegis — Secure Authentication Platform

Aegis is a modern authentication platform that provides Email & Password authentication, JWT-based sessions, and Time-based Multi-Factor Authentication (TOTP) using authenticator apps.

It is designed as a backend-driven authentication system with clear MFA lifecycle management, making it suitable for real-world applications, enterprise systems, and security-focused products.

---

## Why Aegis?

Authentication systems are often either:
* **Too simple** — password-only login with weak security.
* **Too fragmented** — MFA handled separately with no backend awareness.
* **Hard to extend** — tightly coupled and difficult to scale.

Aegis solves this by treating authentication as a first-class platform.

---

## Problem

Modern applications require strong authentication, but developers face several challenges:
* Password-only authentication is insecure.
* MFA is often added as an afterthought.
* OTP apps are device-bound, not account-aware.
* No visibility into MFA state during login.
* Hard to manage sessions, re-logins, and MFA verification.
* Frontend and backend MFA logic are disconnected.

These issues lead to systems that are hard to scale, hard to audit, and hard to trust.

---

## Solution

Aegis provides a clean, backend-driven authentication flow:
* **Secure Auth:** Email and password authentication with BCrypt hashing.
* **Session Management:** JWT-based stateless session management.
* **TOTP-based MFA:** Using industry-standard algorithms (RFC 6238).
* **Lifecycle Management:** Backend-controlled MFA states (Enroll → Confirm → Verify).
* **Universal Compatibility:** QR-based enrollment for Google Authenticator or the Aegis app.
* **Separation of Concerns:** Clear boundaries across backend, mobile, and web.

---

## Core Features

### Authentication
- Email and password login
- BCrypt password hashing
- JWT token generation
- MFA-aware login flow

### Multi-Factor Authentication (MFA)
- TOTP-based MFA (RFC 6238 compatible)
- QR code enrollment
- Compatible with Google Authenticator and Aegis Authenticator
- Backend-side OTP verification
- 30-second rolling codes
- MFA state management (PENDING → ACTIVE)

### Client Support
- **Flutter-based** authenticator app
- **Web-based** login and QR enrollment (Next.js)
- API-driven authentication flows

### Architecture
- Modular Spring Boot backend
- Clean REST APIs
- Database-backed MFA state
- Stateless authentication using JWT

---

## Repository Structure

```text
Aegis/
├── Backend/
│   ├── auth-core/
│   │   ├── src/main/java/com/aegis/auth/
│   │   │   ├── controller/      # Auth, MFA, and Health endpoints
│   │   │   ├── service/         # Business logic for JWT, MFA, and Passwords
│   │   │   ├── entity/          # JPA Entities (User, MfaSecret)
│   │   │   ├── repository/      # Spring Data JPA Repositories
│   │   │   ├── dto/             # Data Transfer Objects for API
│   │   │   ├── security/        # Spring Security & JWT Filters
│   │   │   └── util/            # QR and TOTP Utilities
│   │   ├── Dockerfile
│   │   └── pom.xml
├── Frontend/
│   ├── flutter-app/             # Mobile Authenticator App
│   │   ├── lib/
│   │   │   ├── screens/         # QR Scan, OTP List, Verify
│   │   │   ├── services/        # MFA API Integration
│   │   │   └── models/          # Data Models
├── Web/
│   ├── aegis-web/               # Next.js Web Dashboard
│   │   ├── pages/               # Login, Enroll, Verify pages
│   │   ├── components/          # UI Components (QrViewer, OtpInput)
│   │   └── services/            # API Client
├── docs/                        # Architecture and Flow diagrams
├── docker-compose.yaml
└── README.md

```

---

## Authentication Flow

### 1. Login

User submits `Email + Password`. The Backend validates credentials using BCrypt.

### 2. MFA Check

* **If MFA is ACTIVE:** Backend returns a temporary state prompting for OTP.
* **If MFA is NOT ACTIVE:** Backend issues a full Access JWT.

### 3. MFA Enrollment

`POST /mfa/enroll` → Returns a QR Code → Scanned by Authenticator App.

### 4. MFA Confirmation

User enters first OTP → `POST /mfa/confirm` → MFA status updated to **ACTIVE**.

### 5. MFA Verification (Subsequent Logins)

User enters OTP → `POST /mfa/verify` → Backend validates and issues final JWT.

---

## Flutter App (Authenticator)

The Flutter app acts as a secure OTP generator.

**Key Screens:**

* **QR Scan:** For enrolling new accounts.
* **OTP List:** Supporting multiple accounts.
* **Countdown UI:** 30-second rotation visualization.
* **Manual Verification:** Direct entry support.

**Design Goals:**

* Minimal interface with fast OTP refresh.
* Secure local storage for secrets.
* Account-centric model.

---

## Web App (Next.js)

The web app handles user-facing authentication flows and dashboard access.

**Pages:**

* `login.tsx`: Email/Password entry.
* `enroll.tsx`: Displays QR for MFA setup.
* `verify.tsx`: Secure OTP input field.
* `dashboard.tsx`: Protected user area.

---

## Tech Stack

| Layer | Technology |
| --- | --- |
| **Backend** | Java 21, Spring Boot, Spring Security, JPA, PostgreSQL |
| **Auth** | JWT (JSON Web Tokens), BCrypt, java-otp |
| **Mobile** | Flutter (Dart), Material UI, Secure Storage |
| **Web** | Next.js, TypeScript, Tailwind CSS |
| **Utilities** | ZXing (QR Generation), Docker |

---

## Future Enhancements

* **Redis:** For OTP window caching and session TTL management.
* **Kafka:** For authentication events and audit logging.
* **Security:** Device fingerprinting and risk-based MFA.
* **Recovery:** Implementation of backup recovery codes.

---

## Design Philosophy

Aegis is built with **explicit authentication state transitions**, ensuring that the backend always dictates the security requirements. By utilizing a **backend-first** approach, client-side implementation remains simple while maintaining high security standards and extensibility.

---

## Conclusion

Aegis is a complete authentication platform foundation demonstrating real-world flows, security best practices, and a modular architecture. It is suitable for production applications, system design references, and portfolio showcases.

