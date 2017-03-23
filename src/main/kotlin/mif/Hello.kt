package mif

import data.User
import spark.Spark.*
import com.fasterxml.jackson.*

fun main(args: Array<String>) {
//    println("Hello, World")

    val userDao = UserDao()

    path("/users") {

        get("") { req, res ->
            jacksonObjectMapper().writeValueAsString(userDao.users)
        }

        get("/:id") { req, res ->
            userDao.findById(req.params("id").toInt())
        }

        get("/email/:email") { req, res ->
            userDao.findByEmail(req.params("email"))
        }

        post("/create") { req, res ->
            userDao.save(name = req.queryParams("name"), email = req.queryParams("email"))
            res.status(201)
            "ok"
        }

        patch("/update/:id") { req, res ->
            userDao.update(
                    id = req.params("id").toInt(),
                    name = req.queryParams("name"),
                    email = req.queryParams("email")
            )
            "ok"
        }

        delete("/delete/:id") { req, res ->
            userDao.delete(req.params("id").toInt())
            "ok"
        }

    }

    // add "qp()" alias for "queryParams()" on Request object
//    fun Request.qp(key: String): String = this.queryParams(key)


}

