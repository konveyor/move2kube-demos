package io.konveyor.demo.inventory.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import io.opentracing.Tracer;

@Configuration
public class Config {
    @Bean
    public Tracer tracer() {
        return new io.jaegertracing.Configuration("products").getTracer();
    }
}
