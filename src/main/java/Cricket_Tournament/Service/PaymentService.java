package Cricket_Tournament.Service;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.razorpay.RazorpayException;

@Service
public class PaymentService {

    @Value("${razorpay.key.id}")
    private String keyId;

    @Value("${razorpay.key.secret}")
    private String keySecret;

    public String createOrder(int amountInRupees) throws RazorpayException {
        RazorpayClient client = new RazorpayClient(keyId, keySecret);
        
        JSONObject options = new JSONObject();
        options.put("amount", amountInRupees * 100); // Amount paise mein hota hai (e.g., 500 INR = 50000 paise)
        options.put("currency", "INR");
        options.put("receipt", "txn_" + System.currentTimeMillis());

        Order order = client.orders.create(options);
        return order.get("id"); // Ye Order ID frontend ko bheji jayegi
    }
}