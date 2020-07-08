package com.pando.subalzu.web;

import com.pando.subalzu.exception.StorageFileNotFoundException;
import com.pando.subalzu.service.StorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.Map;

@Controller
public class FileUploadController {

    private final StorageService storageService;

    @Autowired
    public FileUploadController(StorageService storageService) {
        this.storageService = storageService;
    }

    @PostMapping("/upload")
    @ResponseBody
    public Map<String, Object> handleFileUpload(@RequestParam("upload")MultipartFile file) {
        HashMap<String, Object> map = new HashMap<>();
        String url = "/uploads/" + storageService.store(file);
        map.put("url", url);
        map.put("uploaded", true);
        return map;
    }

    @GetMapping("/uploads/{year}/{month}/{day}/{filename:.+}")
    @ResponseBody
    public ResponseEntity<Resource> serveFile(@PathVariable String filename, @PathVariable int year, @PathVariable int month, @PathVariable int day) {
        String filepath = String.format("%d/%d/%d/%s", year, month, day, filename);;
        Resource file = storageService.loadAsResource(filepath);
        return ResponseEntity.ok().header(HttpHeaders.CONTENT_DISPOSITION,
                "attachment; filename=\"" + file.getFilename() + "\"").body(file);
    }

    @ExceptionHandler(StorageFileNotFoundException.class)
    public ResponseEntity<?> handleStorageNotFound(StorageFileNotFoundException exception) {
        return ResponseEntity.notFound().build();
    }
}
