package observerPattern;

import java.util.ArrayList;
import java.util.List;

public class StockMarket implements Stock {
    private List<Observer> observers;
    private String stockName;
    private double stockPrice;

    public StockMarket(String stockName, double stockPrice) {
        this.stockName = stockName;
        this.stockPrice = stockPrice;
        this.observers = new ArrayList<>();
    }

    public void setStockPrice(double stockPrice){
        this.stockPrice = stockPrice;
        notifyObservers();
    }

    @Override
    public void notifyObservers(){
        for(Observer observer : observers){
            observer.update(stockName, stockPrice);
        }
    }

    @Override
    public void register(Observer observer){
        observers.add(observer);
    }

    @Override
    public void deregister(Observer observer){
        observers.remove(observer);
    }
}
