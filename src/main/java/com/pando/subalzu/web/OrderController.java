package com.pando.subalzu.web;

import com.pando.subalzu.model.*;
import com.pando.subalzu.repository.*;
import com.pando.subalzu.validator.OrderValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.datatables.mapping.DataTablesInput;
import org.springframework.data.jpa.datatables.mapping.DataTablesOutput;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class OrderController {

    @Autowired
    ShopRepository shopRepository;

    @Autowired
    UserRepository userRepository;

    @Autowired
    ProductRepository productRepository;

    @Autowired
    OrderRepository orderRepository;

    @Autowired
    OrderDataRepository orderDataRepository;

    @Autowired
    OrderProductRepository orderProductRepository;

    @Autowired
    OrderValidator orderValidator;

    @Autowired
    private PriceGroupRepository priceGroupRepository;

    @ModelAttribute("shops")
    List<Shop> shopList() {
        return shopRepository.findAll();
    }

    @ModelAttribute("deliverers")
    List<User> delivererList() {
        return userRepository.findByRoleName("deliverer");
    }

    @ModelAttribute("salesMans")
    List<User> salesManList() {
        return userRepository.findByRoleName("sales");
    }

    @ModelAttribute("priceGroups")
    List<PriceGroup> priceGroupList() {
        return priceGroupRepository.findAll();
    }

    @GetMapping("/orders")
    public String index() {
        return "order_list";
    }

    @GetMapping("/orders/create")
    public String create(Model model) {
        model.addAttribute("orderForm", new Order());
        return "order_create";
    }

    @RequestMapping(value = "/data/orders", method = RequestMethod.POST)
    @ResponseBody
    public DataTablesOutput<Order> dataOrders(@Valid @RequestBody DataTablesInput input) {
        return orderDataRepository.findAll(input);
    }

    @PostMapping(value = "/orders/create")
    @ResponseBody
    public Map<String, Object> store(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> resultMap = new HashMap<>();
        Map<String, String[]> requestMap = request.getParameterMap();

        Long shopId = Long.valueOf(requestMap.get("shop")[0]);
        String deliveryType = requestMap.get("deliveryType")[0];
        String sRequestDate = requestMap.get("requestDate")[0];
        Long delivererId = Long.valueOf(requestMap.get("deliverer")[0]);
        Long salesManId = Long.valueOf(requestMap.get("salesMan")[0]);
        String requestMemo = requestMap.get("requestMemo")[0];
        String memo = requestMap.get("memo")[0];
        String[] productIds = requestMap.get("productIds[]");
        String[] productCounts = requestMap.get("productCounts[]");
        String[] priceGroups = requestMap.get("priceGroups[]");
        String[] productBuyPrices = requestMap.get("productBuyPrices[]");

        Order order = new Order();

        Optional<Shop> optionalShop = shopRepository.findById(shopId);
        if (optionalShop.isPresent()) {
            order.setShop(optionalShop.get());
        } else {
            Map<String, String> messageMap = new HashMap<>();
            messageMap.put("shop", "필수 입력사항입니다.");
            resultMap.put("error", messageMap);
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return resultMap;
        }
        order.setDeliveryType(deliveryType);
        try {
            Date requestDate = new SimpleDateFormat("yyyy-MM-dd").parse(sRequestDate);
            order.setRequestDate(requestDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        Optional<User> optionalDeliverer = userRepository.findById(delivererId);
        if (optionalDeliverer.isPresent()) {
            order.setDeliverer(optionalDeliverer.get());
        } else {
            Map<String, String> messageMap = new HashMap<>();
            messageMap.put("deliverer", "필수 입력사항입니다.");
            resultMap.put("error", messageMap);
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return resultMap;
        }
        Optional<User> optionalSalesMan = userRepository.findById(salesManId);
        optionalSalesMan.ifPresent(order::setSalesMan);
        order.setRequestMemo(requestMemo);
        order.setMemo(memo);

        Order savedOrder = orderRepository.save(order);

        if (productIds.length == 0) {
            Map<String, String> messageMap = new HashMap<>();
            messageMap.put("productIds[]", "필수 입력사항입니다.");
            resultMap.put("error", messageMap);
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return resultMap;
        }
        for (int i = 0; i < productIds.length; i++) {
            OrderProduct orderProduct = new OrderProduct();

            Optional<Product> optionalProduct = productRepository.findById(Long.valueOf(productIds[i]));
            optionalProduct.ifPresent(orderProduct::setProduct);
            Optional<PriceGroup> optionalPriceGroup = priceGroupRepository.findById(Long.valueOf(priceGroups[i]));
            optionalPriceGroup.ifPresent(orderProduct::setPriceGroup);
            orderProduct.setPrice(Long.valueOf(productBuyPrices[i]));
            orderProduct.setProductCount(Integer.parseInt(productCounts[i]));
            orderProduct.setOrder(savedOrder);
            orderProductRepository.save(orderProduct);
        }
        resultMap.put("message", "Success");
        return resultMap;
    }

    @GetMapping("/orders/{id}")
    public String show(@PathVariable String id) {
        return "/order_show";
    }

    @GetMapping("/orders/transaction-details")
    public String transactionDetails() {
        return "/transaction_details";
    }

    @GetMapping("/orders/release")
    public String release() {
        return "/order_release";
    }

    @GetMapping("/product-orders")
    public String ordersPerProduct() {
        return "orders_per_product";
    }

    @GetMapping("/returns")
    public String returnedOrders() {
        return "returned_orders";
    }

    @GetMapping("/order-setting")
    public String setting() {
        return "order_setting";
    }
}
