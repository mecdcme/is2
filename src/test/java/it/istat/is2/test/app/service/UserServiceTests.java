/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.istat.is2.test.app.service;

import it.istat.is2.app.dao.UserDao;
import it.istat.is2.app.dao.UserRolesDao;
import it.istat.is2.app.domain.User;
import it.istat.is2.app.service.UserService;
import it.istat.is2.test.TestBase;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;


import java.util.*;

import static org.junit.Assert.*;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class UserServiceTests extends TestBase {

    @Mock UserDao userDao;
    @Mock UserRolesDao userRolesDao;

    @InjectMocks
    UserService userService;

    @Test
    public void userService_FindExistingUserById_ShouldReturnUser() {
        // Arrange
        User mockedUser = new User(1L, "admin@is2.it");
        when(userDao.findById(1L)).thenReturn(Optional.of(mockedUser));
        
       
        Long id = 1L;
        System.out.println(id);
        // Act
        User user = userService.findOne(id);
        System.out.println(user);
        
        // Assert
        assertNotNull(user);
        assertEquals("admin@is2.it", user.getEmail());
    }

    @Test
    public void userService_FindUsers_ShouldReturnAllUsers() {
        // Arrange
      //  User user1 = new User(83L, "fra@fra.it");
        User user2 = new User(2L, "user@is2.it");
        User user3 = new User(1L, "admin@is2.it");
       // List<User> mockedUsers = Arrays.asList(user1, user2,user3);
        List<User> mockedUsers = Arrays.asList(user2,user3);

        when(userDao.findAll()).thenReturn(mockedUsers);
        when(userRolesDao.findAll()).thenReturn(Arrays.asList());

        // Act
        List<User> users = userService.findAll();

        // Assert
        assertEquals(2, users.size());
    }
}
