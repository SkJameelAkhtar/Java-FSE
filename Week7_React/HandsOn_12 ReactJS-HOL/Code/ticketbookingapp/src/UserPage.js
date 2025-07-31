import React from 'react';
import FlightDetails from './FlightDetails';

const UserPage = () => {
  return (
    <div>
      <h1>Welcome to the Booking Portal!</h1>
      <p>You can now book your tickets.</p>
      <FlightDetails showBookingButton={true} />
    </div>
  );
};

export default UserPage;