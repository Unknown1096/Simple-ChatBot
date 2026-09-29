<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>ChatBot - Login</title>

    <style>

        * {
            box-sizing: border-box;
        }

        :root {
            --primary: #2563eb;
            --primary-dark: #1d4ed8;
            --indigo: #4f46e5;
            --text: #172033;
            --muted: #64748b;
            --border: #e2e8f0;
        }

        body {
            margin: 0;
            min-height: 100vh;

            font-family:
                Inter,
                -apple-system,
                BlinkMacSystemFont,
                "Segoe UI",
                Roboto,
                Arial,
                sans-serif;

            color: var(--text);

            background:
                radial-gradient(
                    circle at 10% 10%,
                    rgba(37, 99, 235, 0.13),
                    transparent 30%
                ),
                radial-gradient(
                    circle at 90% 90%,
                    rgba(99, 102, 241, 0.12),
                    transparent 30%
                ),
                linear-gradient(
                    135deg,
                    #f8fbff,
                    #edf4ff
                );

            display: flex;
            align-items: center;
            justify-content: center;

            padding: 24px;
        }

        .page {
            width: 100%;
            max-width: 1050px;
            min-height: 650px;

            display: grid;
            grid-template-columns: 1fr 1fr;

            background: rgba(255,255,255,0.94);

            border-radius: 28px;

            overflow: hidden;

            box-shadow:
                0 30px 80px rgba(30, 64, 175, 0.15);

            border: 1px solid rgba(255,255,255,0.8);
        }

        .hero {
            position: relative;

            padding: 60px 50px;

            background:
                linear-gradient(
                    145deg,
                    #1d4ed8,
                    #2563eb 45%,
                    #4f46e5
                );

            color: white;

            overflow: hidden;

            display: flex;
            align-items: center;
        }

        .hero::before,
        .hero::after {
            content: "";

            position: absolute;

            border-radius: 50%;

            background: rgba(255,255,255,0.08);
        }

        .hero::before {
            width: 380px;
            height: 380px;

            right: -180px;
            top: -140px;
        }

        .hero::after {
            width: 300px;
            height: 300px;

            left: -180px;
            bottom: -150px;
        }

        .hero-content {
            position: relative;
            z-index: 2;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 12px;

            margin-bottom: 35px;
        }

        .brand-icon {
            width: 50px;
            height: 50px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 15px;

            background: rgba(255,255,255,0.17);

            font-size: 23px;
            font-weight: 800;
        }

        .brand-name {
            font-size: 22px;
            font-weight: 800;
        }

        .hero h1 {
            margin: 0 0 18px;

            font-size: 48px;
            line-height: 1.08;

            letter-spacing: -1.5px;
        }

        .hero p {
            margin: 0;

            max-width: 430px;

            color: rgba(255,255,255,0.8);

            font-size: 16px;
            line-height: 1.7;
        }

        .features {
            margin-top: 38px;

            display: flex;
            flex-direction: column;

            gap: 14px;
        }

        .feature {
            display: flex;
            align-items: center;

            gap: 12px;

            color: rgba(255,255,255,0.9);

            font-size: 14px;
        }

        .check {
            width: 25px;
            height: 25px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 50%;

            background: rgba(255,255,255,0.15);

            font-size: 12px;
        }

        .auth-panel {
            padding: 55px;

            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .auth-header {
            margin-bottom: 25px;
        }

        .auth-header h2 {
            margin: 0 0 8px;

            font-size: 30px;

            letter-spacing: -0.8px;
        }

        .auth-header p {
            margin: 0;

            color: var(--muted);

            font-size: 14px;
        }

        .tabs {
            display: grid;
            grid-template-columns: 1fr 1fr;

            padding: 5px;

            margin-bottom: 24px;

            background: #f1f5f9;

            border-radius: 12px;
        }

        .tab {
            border: none;

            background: transparent;

            padding: 11px;

            border-radius: 9px;

            color: var(--muted);

            font-size: 14px;
            font-weight: 600;

            cursor: pointer;
        }

        .tab.active {
            background: white;

            color: var(--primary);

            box-shadow:
                0 2px 8px rgba(15,23,42,0.07);
        }

        .auth-form {
            display: none;
        }

        .auth-form.active {
            display: block;
        }

        .message {
            padding: 11px 13px;

            border-radius: 10px;

            margin-bottom: 16px;

            font-size: 13px;

            line-height: 1.4;
        }

        .error {
            color: #b91c1c;

            background: #fef2f2;

            border: 1px solid #fecaca;
        }

        .success {
            color: #166534;

            background: #f0fdf4;

            border: 1px solid #bbf7d0;
        }

        .field {
            margin-bottom: 17px;
        }

        .field label {
            display: block;

            margin-bottom: 7px;

            color: #334155;

            font-size: 13px;
            font-weight: 600;
        }

        .input-wrapper {
            position: relative;
        }

        .input {
            width: 100%;
            height: 49px;

            padding: 0 15px;

            border: 1px solid var(--border);

            border-radius: 11px;

            outline: none;

            background: #f8fafc;

            color: var(--text);

            font-size: 14px;

            transition:
                border 0.2s,
                box-shadow 0.2s,
                background 0.2s;
        }

        .input:focus {
            background: white;

            border-color: #60a5fa;

            box-shadow:
                0 0 0 4px rgba(37,99,235,0.1);
        }

        .password-input {
            padding-right: 55px;
        }

        .show-password {
            position: absolute;

            right: 10px;
            top: 50%;

            transform: translateY(-50%);

            border: none;

            background: transparent;

            color: #64748b;

            cursor: pointer;

            padding: 6px;

            font-size: 12px;
            font-weight: 600;
        }

        .submit-button {
            width: 100%;
            height: 49px;

            margin-top: 3px;

            border: none;

            border-radius: 11px;

            background:
                linear-gradient(
                    135deg,
                    var(--primary),
                    var(--indigo)
                );

            color: white;

            font-size: 14px;
            font-weight: 700;

            cursor: pointer;

            box-shadow:
                0 8px 20px rgba(37,99,235,0.2);

            transition:
                transform 0.15s,
                box-shadow 0.2s;
        }

        .submit-button:hover {
            transform: translateY(-1px);

            box-shadow:
                0 12px 25px rgba(37,99,235,0.28);
        }

        .footer-text {
            margin-top: 20px;

            text-align: center;

            color: var(--muted);

            font-size: 13px;
        }

        .footer-text span {
            color: var(--primary);

            font-weight: 600;

            cursor: pointer;
        }

        @media (max-width: 800px) {

            .page {
                grid-template-columns: 1fr;

                max-width: 480px;

                min-height: auto;
            }

            .hero {
                display: none;
            }

            .auth-panel {
                padding: 40px 30px;
            }
        }

    </style>

</head>

<body>

<div class="page">

    <!-- LEFT PANEL -->

    <section class="hero">

        <div class="hero-content">

            <div class="brand">

                <div class="brand-icon">
                    C
                </div>

                <div class="brand-name">
                    ChatBot
                </div>

            </div>

            <h1>
                Chat with<br>
                your people.
            </h1>

            <p>
                Connect with other registered users
                and exchange messages through a
                simple modern chat experience.
            </p>

            <div class="features">

                <div class="feature">
                    <div class="check">✓</div>
                    Direct one-to-one conversations
                </div>

                <div class="feature">
                    <div class="check">✓</div>
                    Messages stored in MySQL
                </div>

                <div class="feature">
                    <div class="check">✓</div>
                    Automatic AJAX updates
                </div>

            </div>

        </div>

    </section>


    <!-- RIGHT PANEL -->

    <section class="auth-panel">

        <div class="auth-header">

            <h2 id="authTitle">
                Welcome back
            </h2>

            <p id="authSubtitle">
                Sign in to continue to ChatBot
            </p>

        </div>


        <!-- TABS -->

        <div class="tabs">

            <button
                type="button"
                id="loginTab"
                class="tab active"
                onclick="showLogin()">

                Login

            </button>

            <button
                type="button"
                id="registerTab"
                class="tab"
                onclick="showRegister()">

                Register

            </button>

        </div>


        <!-- SERVER MESSAGES -->

        <%
            String error =
                    request.getParameter("error");

            String registered =
                    request.getParameter("registered");

            String logout =
                    request.getParameter("logout");

            if ("invalid".equals(error)) {
        %>

            <div class="message error">
                Invalid username or password.
            </div>

        <%
            } else if ("exists".equals(error)) {
        %>

            <div class="message error">
                That username is already registered.
            </div>

        <%
            } else if ("empty".equals(error)) {
        %>

            <div class="message error">
                Please fill in all fields.
            </div>

        <%
            } else if ("db".equals(error)) {
        %>

            <div class="message error">
                A database error occurred.
            </div>

        <%
            }

            if ("true".equals(registered)) {
        %>

            <div class="message success">
                Account created successfully.
                You can now log in.
            </div>

        <%
            }

            if ("true".equals(logout)) {
        %>

            <div class="message success">
                You have been logged out successfully.
            </div>

        <%
            }
        %>


        <!-- LOGIN -->

        <div
            id="loginForm"
            class="auth-form active">

            <form
                method="post"
                action="${pageContext.request.contextPath}/login">

                <div class="field">

                    <label>
                        Username
                    </label>

                    <input
                        class="input"
                        type="text"
                        name="username"
                        placeholder="Enter your username"
                        autocomplete="username"
                        required>

                </div>


                <div class="field">

                    <label>
                        Password
                    </label>

                    <div class="input-wrapper">

                        <input
                            id="loginPassword"
                            class="input password-input"
                            type="password"
                            name="password"
                            placeholder="Enter your password"
                            autocomplete="current-password"
                            required>

                        <button
                            type="button"
                            class="show-password"
                            onclick="togglePassword(
                                'loginPassword',
                                this
                            )">

                            Show

                        </button>

                    </div>

                </div>


                <button
                    type="submit"
                    class="submit-button">

                    Sign in

                </button>

            </form>


            <div class="footer-text">

                Don't have an account?

                <span onclick="showRegister()">
                    Create one
                </span>

            </div>

        </div>


        <!-- REGISTER -->

        <div
            id="registerForm"
            class="auth-form">

            <form
                method="post"
                action="${pageContext.request.contextPath}/register">

                <div class="field">

                    <label>
                        Username
                    </label>

                    <input
                        class="input"
                        type="text"
                        name="username"
                        placeholder="Choose a username"
                        autocomplete="username"
                        required>

                </div>


                <div class="field">

                    <label>
                        Password
                    </label>

                    <div class="input-wrapper">

                        <input
                            id="registerPassword"
                            class="input password-input"
                            type="password"
                            name="password"
                            placeholder="Create a password"
                            autocomplete="new-password"
                            required>

                        <button
                            type="button"
                            class="show-password"
                            onclick="togglePassword(
                                'registerPassword',
                                this
                            )">

                            Show

                        </button>

                    </div>

                </div>


                <button
                    type="submit"
                    class="submit-button">

                    Create account

                </button>

            </form>


            <div class="footer-text">

                Already have an account?

                <span onclick="showLogin()">
                    Sign in
                </span>

            </div>

        </div>

    </section>

</div>


<script>

    function showLogin() {

        document
            .getElementById("loginForm")
            .classList.add("active");

        document
            .getElementById("registerForm")
            .classList.remove("active");

        document
            .getElementById("loginTab")
            .classList.add("active");

        document
            .getElementById("registerTab")
            .classList.remove("active");

        document
            .getElementById("authTitle")
            .textContent = "Welcome back";

        document
            .getElementById("authSubtitle")
            .textContent =
            "Sign in to continue to ChatBot";
    }


    function showRegister() {

        document
            .getElementById("registerForm")
            .classList.add("active");

        document
            .getElementById("loginForm")
            .classList.remove("active");

        document
            .getElementById("registerTab")
            .classList.add("active");

        document
            .getElementById("loginTab")
            .classList.remove("active");

        document
            .getElementById("authTitle")
            .textContent =
            "Create your account";

        document
            .getElementById("authSubtitle")
            .textContent =
            "Register to start chatting";
    }


    function togglePassword(id, button) {

        const input =
            document.getElementById(id);

        if (input.type === "password") {

            input.type = "text";

            button.textContent = "Hide";

        } else {

            input.type = "password";

            button.textContent = "Show";
        }
    }

</script>

</body>

</html>