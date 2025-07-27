import React from 'react';
import FlightDetails from './FlightDetails';

const GuestPage = () => {
  return (
    <div>
      <h1>Welcome, Guest!</h1>
      <p>Please log in to book your tickets.</p>
      <FlightDetails showBookingButton={false} />
    </div>
  );
};

export default GuestPage;