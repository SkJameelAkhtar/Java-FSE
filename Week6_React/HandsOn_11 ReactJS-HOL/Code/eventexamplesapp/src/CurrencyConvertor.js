import React, { useState } from 'react';

function CurrencyConvertor() {
  const [inr, setInr] = useState('');
  const [euro, setEuro] = useState(0);

  const conversionRate = 0.0099;

  const handleSubmit = (event) => {
    event.preventDefault(); 
    const euroValue = parseFloat(inr) * conversionRate;
    setEuro(euroValue.toFixed(2));
  };

  return (
    <div className="converter-container">
      <h2>Currency Converter</h2>
      <p>Convert Indian Rupees (INR) to Euro (EUR)</p>
      <form onSubmit={handleSubmit}>
        <input
          type="number"
          value={inr}
          onChange={(e) => setInr(e.target.value)}
          placeholder="Enter amount in INR"
          className="currency-input"
        />
        <button type="submit" className="action-button">Convert</button>
      </form>
      {euro > 0 && (
        <h3>
          Converted Amount: €{euro}
        </h3>
      )}
    </div>
  );
}

export default CurrencyConvertor;