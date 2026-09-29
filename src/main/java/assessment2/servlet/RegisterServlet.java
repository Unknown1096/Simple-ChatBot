package assessment2.servlet;

import assessment2.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLIntegrityConstraintViolationException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

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
                "INSERT INTO users (username, password) VALUES (?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            ps.executeUpdate();

            response.sendRedirect("login.jsp?registered=true");

        } catch (SQLIntegrityConstraintViolationException e) {

            response.sendRedirect("login.jsp?error=exists");

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect("login.jsp?error=db");
        }
    }
}