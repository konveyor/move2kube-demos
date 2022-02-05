package io.konveyor.demo.inventory.service;

import java.util.NoSuchElementException;
import java.util.Optional;
import org.jboss.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import io.konveyor.demo.inventory.model.Product;
import io.konveyor.demo.inventory.repository.ProductRepository;
import io.opentracing.Span;
import io.opentracing.Tracer;

@Service
@Transactional
public class ProductService {

	private static Logger logger = Logger.getLogger( ProductService.class.getName() );

	@Autowired
	private ProductRepository repository;
	
	@Autowired
	Tracer tracer;
	
	/**
	 * Finds an {@link Product} using its {@code id} as search criteria
	 * @param id The {@link Product} {@code id}
	 * @return The {@link Product} with the supplied {@code id}, {@literal null} if no {@link Product} is found. 
	 */
	public Product findById(Long id) {
		Span span = tracer.buildSpan("findById").start();
		logger.debug("Entering ProductService.findById()");
		Optional<Product> o = repository.findById(id);
		try {
			Product product = o.get();
			logger.debug("Returning element: " + o);
			return product;
		} catch (NoSuchElementException nsee) {
			logger.debug("No element found, returning null");
			return null;
		} finally {
			span.finish();
		}
	}
	
	public Page<Product>findAll(Pageable pageable) {
		logger.debug("Entering ProductService.findAll()");
		Page<Product> p = repository.findAll(pageable);
		logger.debug("Returning element: " + p);
		return p;
	}
}
