package lomayd.SpringLabCICD.api;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
public class UserController {

    @Value("${serverName}")
    private String serverName;
    private Integer visitedCount = 0;

    @GetMapping("/")
    public ResponseEntity<Map<String, String>> getServerInfo() {
        visitedCount++;

        Map<String, String> serverInfo = new HashMap<>();
        serverInfo.put("serverName: ", serverName);
        serverInfo.put("visitedCount: ", visitedCount.toString());

        return ResponseEntity.ok(serverInfo);
    }
}