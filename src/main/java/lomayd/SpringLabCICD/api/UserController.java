package lomayd.SpringLabCICD.api;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class UserController {

    @Value("${app.version}")
    private String version;

    @GetMapping("/")
    public String getAppVersion() {
        return "App Version: " + version;
    }
}