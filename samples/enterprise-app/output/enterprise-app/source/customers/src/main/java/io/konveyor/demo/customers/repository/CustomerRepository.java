package io.konveyor.demo.customers.repository;

import org.springframework.data.repository.PagingAndSortingRepository;

import io.konveyor.demo.customers.model.Customer;

public interface CustomerRepository extends PagingAndSortingRepository<Customer, Long> {

}
