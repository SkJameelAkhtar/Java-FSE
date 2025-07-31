import React, { useState } from 'react';
import GuestPage from './GuestPage';
import UserPage from './UserPage';
import './App.css';

function App() {
  const [isLoggedIn, setIsLoggedIn] = useState(false);

  const handleLogin = () => {
    setIsLoggedIn(true);
  };

  const handleLogout = () => {
    setIsLoggedIn(false);
  };

  return (
    <div className="App">
      <nav className="navbar">
        <h1 className="logo">TicketBookingApp</h1>
        {isLoggedIn ? (
          <button onClick={handleLogout} className="auth-button">Logout</button>
        ) : (
          <button onClick={handleLogin} className="auth-button">Login</button>
        )}
      </nav>

      <div className="content">
        {isLoggedIn ? <UserPage /> : <GuestPage />}
      </div>
    </div>
  );
}

export default App;