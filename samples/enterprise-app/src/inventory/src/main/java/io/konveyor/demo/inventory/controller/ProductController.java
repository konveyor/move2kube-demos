package io.konveyor.demo.inventory.controller;

import org.jboss.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import io.konveyor.demo.inventory.exception.ResourceNotFoundException;
import io.konveyor.demo.inventory.model.Product;
import io.konveyor.demo.inventory.service.ProductService;
import io.opentracing.Span;
import io.opentracing.Tracer;

@RestController
@RequestMapping("/products")
public class ProductController {
	
	private static Logger logger = Logger.getLogger( ProductController.class.getName() );

	@Autowired
	private ProductService productService;
	
	@Autowired
	Tracer tracer;
	
	@GetMapping(value = "/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
    public Product getById(@PathVariable("id") Long id) {
		Product o;
		Span span = tracer.buildSpan("getById").start();
		try{
			logger.debug("Entering ProductController.getById()");
			o = productService.findById(id);
			if (o == null) {
				throw new ResourceNotFoundException("Requested product doesn't exist");
			}
			logger.debug("Returning element: " + o);
		} finally {
			span.finish();
		}
		return o;
	}
	
	@RequestMapping
	public Page<Product> findAll(Pageable pageable){
		return productService.findAll(pageable);
	}

}
