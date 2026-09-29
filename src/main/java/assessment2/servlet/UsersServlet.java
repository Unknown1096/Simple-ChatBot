package assessment2.servlet;

import assessment2.DBConnection;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/users")
public class UsersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("username") == null) {

            response.setStatus(401);
            response.getWriter().write("[]");
            return;
        }

        String currentUser =
                (String) session.getAttribute("username");

        String sql =
                "SELECT username FROM users " +
                "WHERE username <> ? " +
                "ORDER BY username";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, currentUser);

            ResultSet rs = ps.executeQuery();

            StringBuilder json =
                    new StringBuilder("[");

            boolean first = true;

            while (rs.next()) {

                if (!first) {
                    json.append(",");
                }

                String username =
                        rs.getString("username");

                json.append("\"")
                    .append(escapeJson(username))
                    .append("\"");

                first = false;
            }

            json.append("]");

            response.getWriter().write(
                    json.toString()
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.setStatus(500);
            response.getWriter().write("[]");
        }
    }

    private String escapeJson(String value) {

        return value
                .replace("\\", "\\\\")
                .replace("\"", "\\\"");
    }
}