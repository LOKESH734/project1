<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart - SmartCampus Marketplace</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f1f4f9;
            color: #333;
            padding: 20px;
            transition: background-color 0.5s ease;
        }
        .container {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 30px;
            max-width: 900px;
            margin: auto;
            animation: fadeIn 0.5s ease;
        }
        h1 {
            color: #007bff;
            text-align: center;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr:hover {
            background-color: #f1f1f1;
            transition: background-color 0.3s ease;
        }
        .footer {
            text-align: center;
            margin-top: 20px;
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Your Cart</h1>

    <%
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Establish the connection
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce", "root", "tiger");
            // Create a statement
            stmt = conn.createStatement();
            // Execute a query to retrieve all order details (simulating cart contents)
            String sql = "SELECT product_id, name, quantity, price, total_price FROM orderdetails"; // Assuming OrderDetails represents cart items
            rs = stmt.executeQuery(sql);
    %>

    <table>
        <thead>
            <tr>
                <th>Product ID</th>
                <th>Product Name</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Total Price</th>
            </tr>
        </thead>
        <tbody>
            <%
                // Iterate over the result set and display each cart item
                if (!rs.isBeforeFirst()) {
                    out.println("<tr><td colspan='5'>Your cart is empty!</td></tr>");
                } else {
                    while (rs.next()) {
                        int productId = rs.getInt("product_id");
                        String productName = rs.getString("name");
                        int quantity = rs.getInt("quantity");
                        double price = rs.getDouble("price");
                        double totalPrice = rs.getDouble("total_price");
            %>
            <tr>
                <td><%= productId %></td>
                <td><%= productName %></td>
                <td><%= quantity %></td>
                <td>₹<%= String.format("%.2f", price) %></td>
                <td>₹<%= String.format("%.2f", totalPrice) %></td>
            </tr>
            <%
                    }
                }
            %>
        </tbody>
    </table>

    <%
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error retrieving cart items. Please try again later.</p>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    %>

    <div class="footer">
        <p>&copy; 2024 SmartCampus Marketplace. All rights reserved.</p>
    </div>
</div>

</body>
</html>
