<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String username =
            (String) session.getAttribute("username");

    if (username == null) {
        response.sendRedirect(
            request.getContextPath() + "/login.jsp"
        );
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>ChatBot</title>

    <style>

        * {
            box-sizing: border-box;
        }

        :root {
            --primary: #2563eb;
            --indigo: #4f46e5;
            --text: #172033;
            --muted: #718096;
            --border: #e8edf5;
            --chat-bg: #f7f9fd;
        }

        body {
            margin: 0;

            width: 100%;
            height: 100vh;

            overflow: hidden;

            font-family:
                Inter,
                -apple-system,
                BlinkMacSystemFont,
                "Segoe UI",
                Roboto,
                Arial,
                sans-serif;

            background:
                radial-gradient(
                    circle at 0% 0%,
                    rgba(37,99,235,0.08),
                    transparent 28%
                ),
                #f4f7fc;

            color: var(--text);
        }

        .app {
            width: min(1200px, 96vw);
            height: min(760px, 94vh);

            position: absolute;

            left: 50%;
            top: 50%;

            transform: translate(-50%, -50%);

            display: flex;

            overflow: hidden;

            background: white;

            border-radius: 24px;

            border: 1px solid #e4eaf3;

            box-shadow:
                0 30px 80px rgba(15,23,42,0.12);
        }

        /* SIDEBAR */

        .sidebar {
            width: 330px;

            display: flex;
            flex-direction: column;

            background: white;

            border-right: 1px solid var(--border);
        }

        .profile {
            padding: 21px;

            display: flex;

            align-items: center;
            justify-content: space-between;

            border-bottom: 1px solid var(--border);
        }

        .profile-left {
            display: flex;

            align-items: center;

            gap: 11px;
        }

        .avatar {
            width: 43px;
            height: 43px;

            display: flex;

            align-items: center;
            justify-content: center;

            border-radius: 13px;

            background:
                linear-gradient(
                    135deg,
                    #2563eb,
                    #4f46e5
                );

            color: white;

            font-size: 16px;
            font-weight: 800;

            box-shadow:
                0 6px 16px rgba(37,99,235,0.22);
        }

        .profile-name {
            font-size: 14px;
            font-weight: 700;
        }

        .profile-status {
            margin-top: 3px;

            display: flex;
            align-items: center;

            gap: 5px;

            color: #94a3b8;

            font-size: 11px;
        }

        .status-dot {
            width: 7px;
            height: 7px;

            border-radius: 50%;

            background: #22c55e;
        }

        .logout-button {
            width: 35px;
            height: 35px;

            border: none;

            background: #f8fafc;

            border-radius: 9px;

            color: #64748b;

            cursor: pointer;

            font-size: 17px;

            transition: 0.2s;
        }

        .logout-button:hover {
            background: #eff6ff;

            color: var(--primary);
        }

        .search {
            padding: 16px 18px 10px;
        }

        .search-box {
            position: relative;
        }

        .search-icon {
            position: absolute;

            left: 12px;
            top: 50%;

            transform: translateY(-50%);

            color: #94a3b8;
        }

        #userSearch {
            width: 100%;
            height: 42px;

            padding: 0 13px 0 36px;

            border: 1px solid var(--border);

            border-radius: 10px;

            outline: none;

            background: #f8fafc;

            font-size: 13px;

            color: var(--text);
        }

        #userSearch:focus {
            background: white;

            border-color: #93c5fd;

            box-shadow:
                0 0 0 3px rgba(37,99,235,0.08);
        }

        .section-title {
            padding: 12px 20px 8px;

            color: #94a3b8;

            font-size: 11px;
            font-weight: 800;

            text-transform: uppercase;

            letter-spacing: 0.8px;
        }

        .user-list {
            flex: 1;

            overflow-y: auto;

            padding: 0 9px 12px;
        }

        .user-item {
            padding: 12px 11px;

            display: flex;

            align-items: center;

            gap: 11px;

            border-radius: 12px;

            cursor: pointer;

            transition: 0.18s;
        }

        .user-item:hover {
            background: #f7faff;

            transform: translateX(2px);
        }

        .user-item.active {
            background:
                linear-gradient(
                    135deg,
                    #eff6ff,
                    #eef2ff
                );
        }

        .user-avatar {
            width: 40px;
            height: 40px;

            flex-shrink: 0;

            display: flex;

            align-items: center;
            justify-content: center;

            border-radius: 12px;

            background:
                linear-gradient(
                    135deg,
                    #dbeafe,
                    #e0e7ff
                );

            color: #1d4ed8;

            font-size: 14px;
            font-weight: 800;
        }

        .user-info {
            min-width: 0;
        }

        .user-name {
            font-size: 14px;
            font-weight: 650;

            white-space: nowrap;

            overflow: hidden;

            text-overflow: ellipsis;
        }

        .user-subtitle {
            margin-top: 3px;

            color: #94a3b8;

            font-size: 11px;
        }

        /* CHAT */

        .chat {
            flex: 1;

            min-width: 0;

            display: flex;

            flex-direction: column;

            background: var(--chat-bg);
        }

        .chat-header {
            height: 76px;

            padding: 0 25px;

            display: flex;

            align-items: center;

            gap: 13px;

            background: white;

            border-bottom: 1px solid var(--border);
        }

        .chat-avatar {
            width: 43px;
            height: 43px;

            display: flex;

            align-items: center;
            justify-content: center;

            border-radius: 13px;

            background:
                linear-gradient(
                    135deg,
                    #2563eb,
                    #4f46e5
                );

            color: white;

            font-size: 15px;
            font-weight: 800;
        }

        .chat-title {
            font-size: 15px;
            font-weight: 750;
        }

        .chat-subtitle {
            margin-top: 3px;

            font-size: 11px;

            color: #94a3b8;
        }

        .messages {
            flex: 1;

            overflow-y: auto;

            padding: 28px 32px;

            display: flex;

            flex-direction: column;

            gap: 4px;
        }

        .message {
            max-width: min(70%, 550px);

            padding: 11px 14px;

            margin-bottom: 8px;

            border-radius: 15px;

            font-size: 13px;

            line-height: 1.55;

            word-wrap: break-word;

            white-space: pre-wrap;
        }

        .sent {
            align-self: flex-end;

            color: white;

            background:
                linear-gradient(
                    135deg,
                    #2563eb,
                    #4f46e5
                );

            border-bottom-right-radius: 5px;

            box-shadow:
                0 5px 15px rgba(37,99,235,0.13);
        }

        .received {
            align-self: flex-start;

            color: #334155;

            background: white;

            border: 1px solid #e5ebf3;

            border-bottom-left-radius: 5px;

            box-shadow:
                0 3px 10px rgba(15,23,42,0.03);
        }

        .message-sender {
            font-size: 10px;
            font-weight: 800;

            margin-bottom: 4px;

            opacity: 0.75;
        }

        .message-time {
            margin-top: 6px;

            font-size: 9px;

            opacity: 0.65;

            text-align: right;
        }

        .empty-state {
            margin: auto;

            text-align: center;

            max-width: 300px;

            color: #94a3b8;
        }

        .empty-icon {
            width: 58px;
            height: 58px;

            margin: 0 auto 15px;

            display: flex;

            align-items: center;
            justify-content: center;

            border-radius: 17px;

            background: #eaf2ff;

            color: var(--primary);

            font-size: 22px;
            font-weight: 800;
        }

        .empty-state h3 {
            margin: 0 0 7px;

            color: #475569;

            font-size: 16px;
        }

        .empty-state p {
            margin: 0;

            font-size: 12px;

            line-height: 1.6;
        }

        /* COMPOSER */

        .composer {
            padding: 15px 22px 20px;

            background: white;

            border-top: 1px solid var(--border);
        }

        .composer-inner {
            display: flex;

            align-items: flex-end;

            gap: 10px;

            padding: 6px;

            border: 1px solid #e2e8f0;

            border-radius: 15px;

            background: #f8fafc;
        }

        .composer-inner:focus-within {
            background: white;

            border-color: #93c5fd;

            box-shadow:
                0 0 0 3px rgba(37,99,235,0.08);
        }

        #messageInput {
            flex: 1;

            min-width: 0;

            max-height: 120px;

            resize: none;

            border: none;

            outline: none;

            background: transparent;

            padding: 9px 10px;

            color: var(--text);

            font-family: inherit;

            font-size: 13px;

            line-height: 1.5;
        }

        #sendButton {
            width: 39px;
            height: 39px;

            flex-shrink: 0;

            display: flex;

            align-items: center;
            justify-content: center;

            border: none;

            border-radius: 11px;

            background:
                linear-gradient(
                    135deg,
                    #2563eb,
                    #4f46e5
                );

            color: white;

            cursor: pointer;

            font-size: 17px;

            box-shadow:
                0 5px 14px rgba(37,99,235,0.2);
        }

        #sendButton:hover {
            transform: translateY(-1px);
        }

        #sendButton:disabled,
        #messageInput:disabled {
            opacity: 0.5;

            cursor: not-allowed;
        }

        .composer-hint {
            margin-top: 6px;

            padding-left: 7px;

            color: #a0aec0;

            font-size: 9px;
        }

        /* TOAST */

        #toast {
            position: fixed;

            left: 50%;
            bottom: 25px;

            transform:
                translate(-50%, 15px);

            opacity: 0;

            padding: 10px 16px;

            border-radius: 10px;

            background: #172033;

            color: white;

            font-size: 12px;

            pointer-events: none;

            transition: 0.2s;
        }

        #toast.show {
            opacity: 1;

            transform:
                translate(-50%, 0);
        }

        ::-webkit-scrollbar {
            width: 5px;
        }

        ::-webkit-scrollbar-thumb {
            background: #d5dce7;

            border-radius: 10px;
        }

        @media (max-width: 800px) {

            .app {
                width: 100vw;
                height: 100vh;

                max-width: none;
                max-height: none;

                border-radius: 0;
            }

            .sidebar {
                width: 75px;
            }

            .profile {
                justify-content: center;
            }

            .profile-name,
            .profile-status,
            .logout-button,
            .search,
            .section-title,
            .user-info {
                display: none;
            }

            .user-item {
                justify-content: center;
            }

            .message {
                max-width: 82%;
            }
        }

    </style>

</head>

<body>

<div class="app">

    <!-- SIDEBAR -->

    <aside class="sidebar">

        <div class="profile">

            <div class="profile-left">

                <div
                    id="myAvatar"
                    class="avatar">
                </div>

                <div>

                    <div class="profile-name">
                        <%= username %>
                    </div>

                    <div class="profile-status">

                        <span class="status-dot"></span>

                        Online

                    </div>

                </div>

            </div>

            <button
                class="logout-button"
                onclick="logout()"
                title="Logout">

                ↪

            </button>

        </div>


        <div class="search">

            <div class="search-box">

                <span class="search-icon">
                    ⌕
                </span>

                <input
                    type="text"
                    id="userSearch"
                    placeholder="Search users..."
                    autocomplete="off">

            </div>

        </div>


        <div class="section-title">
            People
        </div>


        <div
            id="userList"
            class="user-list">

            <div class="empty-state">

                <div class="empty-icon">
                    ...
                </div>

                <h3>
                    Loading
                </h3>

            </div>

        </div>

    </aside>


    <!-- CHAT -->

    <main class="chat">

        <header class="chat-header">

            <div
                id="chatAvatar"
                class="chat-avatar">

                C

            </div>

            <div>

                <div
                    id="chatTitle"
                    class="chat-title">

                    Select a person

                </div>

                <div
                    id="chatSubtitle"
                    class="chat-subtitle">

                    Choose someone to start chatting

                </div>

            </div>

        </header>


        <div
            id="messages"
            class="messages">

            <div class="empty-state">

                <div class="empty-icon">
                    C
                </div>

                <h3>
                    Your conversations
                </h3>

                <p>
                    Select a person from the left
                    to view your conversation.
                </p>

            </div>

        </div>


        <div class="composer">

            <div class="composer-inner">

                <textarea
                    id="messageInput"
                    rows="1"
                    placeholder="Write a message..."
                    disabled></textarea>

                <button
                    id="sendButton"
                    onclick="sendMessage()"
                    disabled
                    title="Send">

                    ↑

                </button>

            </div>

            <div class="composer-hint">
                Enter to send · Shift + Enter for new line
            </div>

        </div>

    </main>

</div>


<div id="toast"></div>


<script>

    const contextPath =
        "<%= request.getContextPath() %>";

    const currentUser =
        "<%= username
            .replace("\\", "\\\\")
            .replace("\"", "\\\"")
            .replace("\r", "")
            .replace("\n", "") %>";

    let selectedUser = "";

    let allUsers = [];


    function getInitial(name) {

        if (!name || name.length === 0) {
            return "?";
        }

        return name.charAt(0).toUpperCase();
    }


    document
        .getElementById("myAvatar")
        .textContent =
        getInitial(currentUser);


    /* LOAD USERS */

    async function loadUsers() {

        try {

            const response =
                await fetch(
                    contextPath + "/users",
                    {
                        cache: "no-store"
                    }
                );

            if (!response.ok) {
                throw new Error();
            }

            allUsers =
                await response.json();

            renderUsers(allUsers);

        } catch (error) {

            console.error(error);

            showToast("Unable to load users");
        }
    }


    /* RENDER USERS */

    function renderUsers(users) {

        const list =
            document.getElementById("userList");

        list.innerHTML = "";


        if (users.length === 0) {

            list.innerHTML = `
                <div class="empty-state"
                     style="margin-top:40px">

                    <div class="empty-icon">
                        ?
                    </div>

                    <h3>
                        No users
                    </h3>

                    <p>
                        No other registered users are available.
                    </p>

                </div>
            `;

            return;
        }


        users.forEach(function(user) {

            const item =
                document.createElement("div");

            item.className =
                "user-item";


            if (user === selectedUser) {
                item.classList.add("active");
            }


            const avatar =
                document.createElement("div");

            avatar.className =
                "user-avatar";

            avatar.textContent =
                getInitial(user);


            const info =
                document.createElement("div");

            info.className =
                "user-info";


            const name =
                document.createElement("div");

            name.className =
                "user-name";

            name.textContent =
                user;


            const subtitle =
                document.createElement("div");

            subtitle.className =
                "user-subtitle";

            subtitle.textContent =
                "Click to message";


            info.appendChild(name);
            info.appendChild(subtitle);

            item.appendChild(avatar);
            item.appendChild(info);


            item.onclick =
                function() {

                    selectUser(
                        user,
                        item
                    );

                };


            list.appendChild(item);

        });
    }


    /* SEARCH */

    document
        .getElementById("userSearch")
        .addEventListener(
            "input",
            function() {

                const query =
                    this.value
                        .trim()
                        .toLowerCase();


                const filtered =
                    allUsers.filter(
                        function(user) {

                            return user
                                .toLowerCase()
                                .includes(query);

                        }
                    );


                renderUsers(filtered);

            }
        );


    /* SELECT USER */

    function selectUser(user, element) {

        selectedUser = user;


        document
            .querySelectorAll(".user-item")
            .forEach(function(item) {

                item.classList.remove("active");

            });


        element.classList.add("active");


        document
            .getElementById("chatAvatar")
            .textContent =
            getInitial(user);


        document
            .getElementById("chatTitle")
            .textContent =
            user;


        document
            .getElementById("chatSubtitle")
            .textContent =
            "Conversation with " + user;


        document
            .getElementById("messageInput")
            .disabled = false;


        document
            .getElementById("sendButton")
            .disabled = false;


        loadMessages();


        document
            .getElementById("messageInput")
            .focus();
    }


    /* LOAD MESSAGES */

    async function loadMessages() {

        if (!selectedUser) {
            return;
        }


        const container =
            document.getElementById("messages");


        const wasAtBottom =
            container.scrollHeight -
            container.scrollTop -
            container.clientHeight <
            100;


        try {

            const response =
                await fetch(
                    contextPath +
                    "/messages?receiver=" +
                    encodeURIComponent(
                        selectedUser
                    ),
                    {
                        cache: "no-store"
                    }
                );


            if (!response.ok) {
                throw new Error();
            }


            const messages =
                await response.json();


            container.innerHTML = "";


            if (messages.length === 0) {

                const empty =
                    document.createElement("div");

                empty.className =
                    "empty-state";


                const icon =
                    document.createElement("div");

                icon.className =
                    "empty-icon";

                icon.textContent =
                    getInitial(selectedUser);


                const title =
                    document.createElement("h3");

                title.textContent =
                    "Start a conversation";


                const paragraph =
                    document.createElement("p");

                paragraph.textContent =
                    "Send the first message to " +
                    selectedUser + ".";


                empty.appendChild(icon);
                empty.appendChild(title);
                empty.appendChild(paragraph);


                container.appendChild(empty);

                return;
            }


            messages.forEach(function(msg) {

                const message =
                    document.createElement("div");

                message.className =
                    "message " +
                    (
                        msg.sender === currentUser
                            ? "sent"
                            : "received"
                    );


                const sender =
                    document.createElement("div");

                sender.className =
                    "message-sender";

                sender.textContent =
                    msg.sender;


                const text =
                    document.createElement("div");

                text.textContent =
                    msg.message;


                const time =
                    document.createElement("div");

                time.className =
                    "message-time";

                time.textContent =
                    formatTime(msg.time);


                message.appendChild(sender);
                message.appendChild(text);
                message.appendChild(time);


                container.appendChild(message);

            });


            if (wasAtBottom) {

                container.scrollTop =
                    container.scrollHeight;

            }

        } catch (error) {

            console.error(error);

            showToast(
                "Unable to load messages"
            );
        }
    }


    /* SEND MESSAGE */

    async function sendMessage() {

        if (!selectedUser) {

            showToast(
                "Select a person first"
            );

            return;
        }


        const input =
            document.getElementById(
                "messageInput"
            );


        const message =
            input.value.trim();


        if (!message) {
            return;
        }


        const data =
            new URLSearchParams();


        data.append(
            "receiver",
            selectedUser
        );


        data.append(
            "message",
            message
        );


        const button =
            document.getElementById(
                "sendButton"
            );


        button.disabled = true;


        try {

            const response =
                await fetch(
                    contextPath + "/messages",
                    {
                        method: "POST",

                        headers: {
                            "Content-Type":
                                "application/x-www-form-urlencoded"
                        },

                        body:
                            data.toString()
                    }
                );


            const result =
                await response.json();


            if (result.success) {

                input.value = "";

                resizeTextarea();

                await loadMessages();

            } else {

                showToast(
                    result.error ||
                    "Message could not be sent"
                );
            }

        } catch (error) {

            console.error(error);

            showToast(
                "Unable to send message"
            );

        } finally {

            button.disabled = false;

            input.focus();
        }
    }


    /* ENTER KEY */

    document
        .getElementById("messageInput")
        .addEventListener(
            "keydown",
            function(event) {

                if (
                    event.key === "Enter" &&
                    !event.shiftKey
                ) {

                    event.preventDefault();

                    sendMessage();

                }

            }
        );


    /* TEXTAREA */

    document
        .getElementById("messageInput")
        .addEventListener(
            "input",
            resizeTextarea
        );


    function resizeTextarea() {

        const input =
            document.getElementById(
                "messageInput"
            );


        input.style.height =
            "auto";


        input.style.height =
            Math.min(
                input.scrollHeight,
                120
            ) + "px";
    }


    /* FORMAT TIME */

    function formatTime(value) {

        if (!value) {
            return "";
        }


        const date =
            new Date(
                value.replace(" ", "T")
            );


        if (isNaN(date.getTime())) {
            return value;
        }


        return date.toLocaleTimeString(
            [],
            {
                hour: "2-digit",
                minute: "2-digit"
            }
        );
    }


    /* TOAST */

    let toastTimer;


    function showToast(message) {

        const toast =
            document.getElementById(
                "toast"
            );


        toast.textContent =
            message;


        toast.classList.add("show");


        clearTimeout(toastTimer);


        toastTimer =
            setTimeout(
                function() {

                    toast.classList.remove(
                        "show"
                    );

                },
                2500
            );
    }


    /* LOGOUT */

    function logout() {

        window.location.href =
            contextPath + "/logout";
    }


    /* INITIAL */

    loadUsers();


    /* AUTO REFRESH */

    setInterval(
        function() {

            if (selectedUser) {
                loadMessages();
            }

        },
        2000
    );

</script>

</body>

</html>