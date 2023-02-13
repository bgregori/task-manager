package com.rh;

import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

@Path("/tasks")
public class TasksResource {

    @GET
    @Produces("application/json")
    public List<Task> getTasks() {
        return Task.listAll();
    }

    @GET
    @Path("{id}")
    @Produces("application/json")
    public Task byId(Long id) {
        return Task.findById(id);
    }

    @POST
    @Produces("application/json")
    public Task createTask(Task newTask) {
        Task t = new Task();
        t.title = newTask.title;
        t.task_text = newTask.task_text;

        t.persist();

        return t;
    }

}