package com.solponge.domain.order_manager;

import lombok.Data;

@Data
public class Delivery {
    String deliveryInfo;
    Long deliveryNum;

    public Delivery() {
    }

    public Delivery(String deliveryInfo, Long deliveryNum) {
        this.deliveryInfo = deliveryInfo;
        this.deliveryNum = deliveryNum;
    }
}
