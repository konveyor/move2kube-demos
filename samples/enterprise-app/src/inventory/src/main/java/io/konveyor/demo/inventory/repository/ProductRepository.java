package io.konveyor.demo.inventory.repository;

import org.springframework.data.repository.PagingAndSortingRepository;

import io.konveyor.demo.inventory.model.Product;

public interface ProductRepository extends PagingAndSortingRepository<Product, Long> {

}
