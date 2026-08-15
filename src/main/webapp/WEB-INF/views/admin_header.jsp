<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- ADMIN NAVBAR -->
<nav style="background: #e2e2e2; padding: 10px; margin-bottom: 20px;">
    <ul style="list-style-type: none; margin: 0; padding: 0; display: flex; gap: 15px; align-items: center; flex-wrap: wrap;">
        <li><a href="/admin/home">Admin Home</a></li>
        <li><a href="/admin/teams">Manage Teams</a></li>
        <li><a href="/admin/tournaments">Manage Tournaments</a></li>
        <li><a href="/admin/matches">Manage Matches</a></li>
        <li><a href="/admin/pointsTable">Points Table</a></li>
        <li><a href="/admin/users">Manage Users</a></li>
        <li><a href="/admin/addPlayerPage">Add Player</a></li>
        <li><a href="/change-password">Change Password</a></li>
        <li><a href="/logout">Logout</a></li>
        
        <!-- Search Bar -->
        <li style="margin-left: auto;">
            <form action="/admin/search" method="get" style="margin: 0;">
                <input type="text" name="keyword" placeholder="Admin Search..." style="padding: 5px;">
                <button type="submit" style="padding: 5px 10px;">Search</button>
            </form>
        </li>
    </ul>
</nav>

<!-- ADMIN PROFILE SECTION -->
<div style="border: 1px solid #999; padding: 15px; margin-bottom: 20px; width: 300px; background: #f9f9f9;">
    <h3>Admin Profile</h3>
    <p><strong>Name:</strong> ${sessionScope.user.name}</p>
    <p><strong>Email:</strong> ${sessionScope.user.email}</p>
    <p><strong>Role:</strong> ${sessionScope.user.role}</p>
    <a href="/change-password">Change Password</a>
</div>