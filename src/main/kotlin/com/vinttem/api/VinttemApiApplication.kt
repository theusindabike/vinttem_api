package com.vinttem.api

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController

@SpringBootApplication
class VinttemApiApplication

fun main(args: Array<String>) {
	runApplication<VinttemApiApplication>(*args)
}

data class Transaction(val id: String?, val value: Double )

@RestController
class TransactionController {
	@GetMapping("/transaction/")
	fun index2(@RequestParam("value") value: Double) = Transaction(id= "", value = value)
}

@RestController
class MessageController {
	@GetMapping("/")
	fun index(@RequestParam("name") name: String) = "hello world, $name"
}
