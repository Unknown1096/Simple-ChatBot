package assessment2.servlet;

import assessment2.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || password == null ||
            username.trim().isEmpty() ||
            password.trim().isEmpty()) {

            response.sendRedirect("login.jsp?error=empty");
            return;
        }

        username = username.trim();

        String sql =
                "SELECT username FROM users " +
                "WHERE username = ? AND password = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    HttpSession session = request.getSession();

                    session.setAttribute(
                            "username",
                            rs.getString("username")
                    );

                    response.sendRedirect("chat.jsp");

                } else {

                    response.sendRedirect("login.jsp?error=invalid");
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect("login.jsp?error=db");
        }
    }
}