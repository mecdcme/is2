/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.istat.is2.test;

import it.istat.is2.IS2Application;
import it.istat.is2.app.domain.User;
import it.istat.is2.app.service.UserService;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringBootTest(classes = IS2Application.class)
public class UserServiceTests {

    @Autowired
    UserService userService;

    public UserServiceTests() {
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {
    }

    @Test
    public void userService_FindExistingUserById_ShouldReturnUser() {
        // Arrange
        Long id = 1L;

        // Act
        User user = userService.findOne(id);

        // Assert
        assertNotNull(user);
    }

    @Test
    public void userService_FindUsers_ShouldReturnAllUsers() {
        // Arrange

        // Act
        List<User> users = userService.findAll();

        // Assert
        assertEquals(2, users.size());
    }
}
