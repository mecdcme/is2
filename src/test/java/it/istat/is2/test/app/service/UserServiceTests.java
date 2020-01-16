/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.istat.is2.test.app.service;

import it.istat.is2.app.dao.*;
import it.istat.is2.app.domain.*;
import it.istat.is2.app.forms.*;
import it.istat.is2.app.service.*;
import it.istat.is2.test.*;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.*;

import static org.junit.Assert.*;
import static org.mockito.Mockito.*;

@RunWith(SpringJUnit4ClassRunner.class)
public class UserServiceTests extends TestBase {

    @Mock UserDao userDao;
    @Mock UserRolesDao userRolesDao;

    @InjectMocks UserService userService;

    @Test
    public void userService_CreateUser_ShouldReturnUser() {
        // Arrange
        UserCreateForm form = new UserCreateForm();
        form.setId(1L);
        form.setEmail("email");
        form.setPassword("password");
        form.setName("name");
        form.setSurname("surname");
        form.setRole((short)1);

        // Act
        User user = userService.create(form);

        // Assert
        assertNotNull(user);
        assertEquals("email", user.getEmail());
        assertNotEquals("password", user.getPassword());
        assertEquals("name", user.getName());
        assertEquals("surname", user.getSurname());

        verify(userDao, times(1)).save(user);
    }

    @Test
    public void userService_UpdateUser_ShouldMakeChangesToUser() throws Exception {
        // Arrange
        Long id = 1L;
        String email = "mbruno@istat.it";

        UserCreateForm form = new UserCreateForm();
        form.setId(id);
        form.setEmail("email");
        form.setPassword("password");
        form.setName("name");
        form.setSurname("surname");
        form.setRole((short)1);

        User mockedUser = new User(id, email);

        when(userDao.findById(1L)).thenReturn(Optional.of(mockedUser));

        // Act
        User user = userService.update(form);

        // Assert
        assertNotNull(user);
        assertEquals("email", user.getEmail());
        assertNotEquals("password", user.getPassword());
        assertEquals("name", user.getName());
        assertEquals("surname", user.getSurname());

        verify(userDao, times(1)).save(user);
    }

    @Test
    public void userService_FindExistingUserById_ShouldReturnUser() {
        // Arrange
        Long id = 1L;
        String email = "mbruno@istat.it";
        User mockedUser = new User(id, email);
        when(userDao.findById(id)).thenReturn(Optional.of(mockedUser));

        // Act
        User user = userService.findOne(id);

        // Assert
        assertNotNull(user);
        assertEquals(email, user.getEmail());
    }

    @Test
    public void userService_FindExistingUserByEmail_ShouldReturnUser() {
        // Arrange
        Long userId = 1L;
        String email = "mbruno@istat.it";
        User mockedUser = new User(userId, email);
        when(userDao.findByEmail(email)).thenReturn(mockedUser);

        // Act
        User user = userService.findByEmail(email);

        // Assert
        assertNotNull(user);
        assertEquals(email, user.getEmail());
    }

    @Test
    public void userService_FindUsers_ShouldReturnAllUsers() {
        // Arrange
        User user1 = new User(1L, "mbruno@istat.it");
        User user2 = new User(2L, "v.broeke@cbs.nl");
        List<User> mockedUsers = Arrays.asList(user1, user2);

        when(userDao.findAll()).thenReturn(mockedUsers);
        when(userRolesDao.findAll()).thenReturn(Arrays.asList());

        // Act
        List<User> users = userService.findAll();

        // Assert
        assertEquals(2, users.size());
    }

    @Test
    public void userService_DeleteUser_ShouldCallDeleteOnDaoOnce() {
        // Arrange
        Long id = 1L;

        // Act
        userService.delete(id);

        // Assert
        verify(userDao, times(1)).deleteById(id);
    }
}
