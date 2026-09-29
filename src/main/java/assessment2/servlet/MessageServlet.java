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

@WebServlet("/messages")
public class MessageServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("username") == null) {

            response.setStatus(401);
            response.getWriter().write("[]");
            return;
        }

        String currentUser =
                (String) session.getAttribute("username");

        String receiver =
                request.getParameter("receiver");

        if (receiver == null ||
            receiver.trim().isEmpty()) {

            response.getWriter().write("[]");
            return;
        }

        String sql =
                "SELECT sender, receiver, message, sent_at " +
                "FROM messages " +
                "WHERE (sender = ? AND receiver = ?) " +
                "OR (sender = ? AND receiver = ?) " +
                "ORDER BY sent_at ASC, id ASC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(sql)) {

            ps.setString(1, currentUser);
            ps.setString(2, receiver);

            ps.setString(3, receiver);
            ps.setString(4, currentUser);

            ResultSet rs =
                    ps.executeQuery();

            StringBuilder json =
                    new StringBuilder("[");

            boolean first = true;

            while (rs.next()) {

                if (!first) {
                    json.append(",");
                }

                String sender =
                        rs.getString("sender");

                String rec =
                        rs.getString("receiver");

                String message =
                        rs.getString("message");

                String time =
                        rs.getTimestamp("sent_at")
                           .toString();

                json.append("{");

                json.append("\"sender\":\"")
                    .append(escapeJson(sender))
                    .append("\",");

                json.append("\"receiver\":\"")
                    .append(escapeJson(rec))
                    .append("\",");

                json.append("\"message\":\"")
                    .append(escapeJson(message))
                    .append("\",");

                json.append("\"time\":\"")
                    .append(escapeJson(time))
                    .append("\"");

                json.append("}");

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


    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("username") == null) {

            response.setStatus(401);

            response.getWriter().write(
                    "{\"success\":false}"
            );

            return;
        }

        String sender =
                (String) session.getAttribute("username");

        String receiver =
                request.getParameter("receiver");

        String message =
                request.getParameter("message");

        if (receiver == null ||
            message == null ||
            receiver.trim().isEmpty() ||
            message.trim().isEmpty()) {

            response.setStatus(400);

            response.getWriter().write(
                    "{\"success\":false,\"error\":\"Invalid message\"}"
            );

            return;
        }

        String sql =
                "INSERT INTO messages " +
                "(sender, receiver, message) " +
                "VALUES (?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(sql)) {

            ps.setString(1, sender);
            ps.setString(2, receiver);
            ps.setString(3, message);

            ps.executeUpdate();

            response.getWriter().write(
                    "{\"success\":true}"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.setStatus(500);

            response.getWriter().write(
                    "{\"success\":false,\"error\":\"Database error\"}"
            );
        }
    }


    private String escapeJson(String value) {

        return value
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\r", "\\r")
                .replace("\n", "\\n")
                .replace("\t", "\\t");
    }
}