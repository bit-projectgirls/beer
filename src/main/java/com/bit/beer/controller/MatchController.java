package com.bit.beer.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import com.bit.beer.repository.BeerVo;
import com.bit.beer.service.BeerService;
import com.bit.beer.service.UserService;


@Controller
public class MatchController {
	private static final Logger logger = LoggerFactory.getLogger(MatchController.class);

	 @Autowired
	   BeerService beerService;
   
   @PostMapping("/imageUpload") // IOException - 파일이 없을 때 발생할 에러.
   public String submitReport1(@RequestParam("filedata") MultipartFile picture, Model model) throws IOException { 
	  
      System.out.println("Start:" + new Date());
      // 플라스크한테 파일 보낼꺼야~(MULTIPART_FORM_DATA);
      HttpHeaders headers = new HttpHeaders();
      headers.setContentType(MediaType.MULTIPART_FORM_DATA);
      
      //  BODY : 실제 데이터
      MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
      
      UUID tempFileName = UUID.randomUUID();
        String tempFileExtensionPlusDot = "."+FilenameUtils.getExtension(picture.getOriginalFilename());
      
      System.out.println(tempFileExtensionPlusDot);
      
      File tempFile = File.createTempFile(tempFileName.toString(), tempFileExtensionPlusDot);
        picture.transferTo(tempFile);
        FileSystemResource fileSystemResource = new FileSystemResource(tempFile);
    
      body.add("picture", fileSystemResource);
      
      HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);
      System.out.println("Flask:" + new Date());
      String serverUrl = "http://127.0.0.1:5000/predict_beer";
      
      RestTemplate restTemplate = new RestTemplate();
      
      ResponseEntity<String> response = restTemplate.postForEntity(serverUrl, requestEntity, String.class);
      System.out.println(response.getBody());
      System.out.println("End:" + new Date());
      model.addAttribute("result", response.getBody());
      String res = response.getBody();
      int start = res.indexOf("[")+1;
      int end = res.indexOf("]");
      res = res.substring(start, end);
      String[] strlist =res.split(",");
      List<BeerVo> list = new ArrayList<>();
      for(String str: strlist) {
         str = str.trim();
         int beerNo = Integer.valueOf(str);
         BeerVo vo = beerService.getBeerInfo(beerNo); 
         list.add(vo);
         
      }
      // TODO: for문 돌려서 번호로 맥주정보 DB에서 받아와서 list에 add해주기
//	  List<BeerVo> list = beerService.getTopList();
      model.addAttribute("beerList", list);
      
      return "beerresult";      
   }
   
  

  
}