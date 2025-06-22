package FinancialForecasting;

import java.text.NumberFormat;
import java.util.Locale;

public class Main {

    public static void main(String[] args) {
        double initialInvestment = 1000.00;
        double annualGrowthRate = 0.05; // 5%
        int years = 10;

        System.out.println("Financial Forecast");
        System.out.println("Initial Investment: " + formatCurrency(initialInvestment));
        System.out.println("Annual Growth Rate: " + (annualGrowthRate * 100) + "%");
        System.out.println("Forecast Period: " + years + " years\n");

        double futureValueRecursive = FinancialForecaster.calculateFutureValue(initialInvestment, annualGrowthRate, years);
        System.out.println("Predicted Value (Recursive):  " + formatCurrency(futureValueRecursive));

    }

    private static String formatCurrency(double value) {
        return NumberFormat.getCurrencyInstance(Locale.US).format(value);
    }
}