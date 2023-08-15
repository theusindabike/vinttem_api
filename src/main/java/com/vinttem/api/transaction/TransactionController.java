package com.vinttem.api.transaction;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@RestController
public class TransactionController {
    @GetMapping("/transactions")
    public List<Transaction> list() {
        List<Transaction> transactions = new ArrayList<Transaction>();
        transactions.add(new Transaction(BigDecimal.ONE));
        return transactions;
    }
}
