package com.vinttem.api.transaction;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.data.annotation.CreatedDate;

import java.math.BigDecimal;
import java.util.Date;

@Data
@RequiredArgsConstructor
@Entity
public class Transaction {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "transaction_value")
    @NonNull
    private final BigDecimal value;

    @Enumerated(EnumType.STRING)
    private TransactionType type;
    @Column(length=255)
    private String description;

    @Temporal(value=TemporalType.TIMESTAMP)
    @Column(name = "transaction_date")
    private Date date;

    @CreatedDate
    private Date cratedAt;

}
