package com.myweb.www.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myweb.www.domain.BoardDTO;
import com.myweb.www.domain.BoardVO;
import com.myweb.www.domain.FileVO;
import com.myweb.www.domain.PagingVO;
import com.myweb.www.handler.FileHandler;
import com.myweb.www.handler.PagingHandler;
import com.myweb.www.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

//@RequiredArgsConstructor 선언 후 
//private final로 객체 등록 => 생성자 주입 / @Inject 대신 사용

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/board/*")
public class BoardController {
	
	private final BoardService bsv;
	
	private final FileHandler fh;
	
	@GetMapping("/register")
	public void register() {}
	
	@PostMapping("/register")
	public String insert(BoardVO bvo, @RequestParam(name="files", required = false) MultipartFile[] files) {
		log.info(">>>> bvo >>>>{} " , bvo);
		List<FileVO> flist = null;
		//fileHandler 생성 - multipartfile 값이 input 되면 => flist가 output 될수 있게
		if(files[0].getSize()>0) {
			flist = fh.uploadFiles(files);
		}
		int isOk = bsv.insert(new BoardDTO(bvo,flist));
		return "index";
	}
	
	@GetMapping("/list")
	public void list(Model m, PagingVO pgvo) {
		log.info(">>>> pagingVO >>{}", pgvo);
		//페이징 처리
		List<BoardVO> list = bsv.getList(pgvo);
		//totalCount 구하기
		int totalCount = bsv.getTotalCount(pgvo);
		PagingHandler ph = new PagingHandler(pgvo, totalCount);
		m.addAttribute("list", list);
		m.addAttribute("ph", ph);
	}
	
	@GetMapping({"/detail", "/modify"})
	public void detail(Model m, @RequestParam("bno") int bno) {
		log.info(">>>> bno >>>>{} " , bno);
		bsv.read(bno);
		m.addAttribute("bdto" , bsv.getdetail(bno));
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO bvo, RedirectAttributes re, 
			@RequestParam(name="files", required = false)MultipartFile[] files) {
		log.info(">>>> bvo >>>>{} " , bvo);
		List<FileVO> flist = null;
		if(files[0].getSize()>0) {
			flist = fh.uploadFiles(files);
		}
		int isOk = bsv.update(new BoardDTO(bvo,flist));
		return "redirect:/board/detail?bno="+bvo.getBno();
	}
	
	@GetMapping("/delete")
	public String delete(@RequestParam("bno") long bno) {
		log.info(">>>> bno >>>>{} " , bno);
		bsv.delete(bno);
		return "/board/list";
	}
	
	@DeleteMapping(value="/file/{uuid}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> removeFile(@PathVariable ("uuid") String uuid){
		log.info(">>>> uuid >>>>{}", uuid);
		int isOk = bsv.delFile(uuid);
		return isOk > 0 ? new ResponseEntity<String>("1",HttpStatus.OK)
				: new ResponseEntity<String>("0",HttpStatus.INTERNAL_SERVER_ERROR);
				
	}
	
	
}
