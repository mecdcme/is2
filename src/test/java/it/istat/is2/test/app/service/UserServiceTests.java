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
        assertTrue(user.getPassword().length() > 0);
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
        form.setEmail(email);
        form.setPassword("password");
        form.setName("name");
        form.setSurname("surname");
        form.setRole((short)1);

        when(userDao.findById(id)).thenReturn(Optional.of(new User(id, "email")));

        // Act
        User user = userService.update(form);

        // Assert
        assertNotNull(user);
        assertEquals(email, user.getEmail());
        assertNull(user.getPassword()); // Update is not updating password
        assertEquals("name", user.getName());
        assertEquals("surname", user.getSurname());

        verify(userDao, times(1)).save(user);
    }

    @Test(expected=Exception.class)
    public void userService_UpdateWithoutUser_ShouldThrowException() throws Exception {
        // Arrange
        Long id = 1L;
        UserCreateForm form = new UserCreateForm();
        form.setId(id);

        when(userDao.findById(id)).thenReturn(null);

        // Act
        User user = userService.update(form);

        // Assert
        assertNull(user);
    }

    @Test
    public void userService_UpdatePasswordByEmail_ShouldUpdatePassword() throws Exception {
        // Arrange
        String email = "mbruno@istat.nl";
        String password = "password";
        String otherPassword = "otherPassword";

        User testUser = new User();
        testUser.setEmail(email);
        testUser.setPassword(password);

        when(userDao.findByEmail(email)).thenReturn(testUser);

        // Act
        User user = userService.updatePasswordByEmail(email, otherPassword);
        String hashedPassword = user.getPassword();

        // Assert
        assertNotNull(user);
        assertEquals(email, user.getEmail());
        assertNotEquals(password, hashedPassword);
        assertNotEquals(otherPassword, hashedPassword);
        assertTrue(hashedPassword.length() > 0);

        verify(userDao, times(1)).save(user);
    }

    @Test(expected=Exception.class)
    public void userService_UpdatePasswordByEmailWithoutUser_ShouldThrowException() throws Exception {
        // Arrange
        String email = "mbruno@istat.nl";
        String password = "password";

        when(userDao.findByEmail(email)).thenReturn(null);

        // Act
        User user = userService.updatePasswordByEmail(email, password);

        // Assert
        assertNull(user);
    }

    @Test
    public void userService_UpdatePasswordById_ShouldUpdatePassword() throws Exception {
        // Arrange
        Long id = 1L;
        String password = "password";
        String otherPassword = "otherPassword";

        User testUser = new User();
        testUser.setId(id);
        testUser.setPassword(password);

        when(userDao.findById(id)).thenReturn(Optional.of(testUser));

        // Act
        User user = userService.updatePasswordById(id, otherPassword);
        String hashedPassword = user.getPassword();

        // Assert
        assertNotNull(user);
        assertEquals(id, user.getId());
        assertNotEquals(password, hashedPassword);
        assertNotEquals(otherPassword, hashedPassword);
        assertTrue(hashedPassword.length() > 0);

        verify(userDao, times(1)).save(user);
    }

    @Test(expected=Exception.class)
    public void userService_UpdatePasswordByIdWithoutUser_ShouldThrowException() throws Exception {
        // Arrange
        Long id = 1L;
        String password = "password";

        when(userDao.findById(id)).thenReturn(null);

        // Act
        User user = userService.updatePasswordById(id, password);

        // Assert
        assertNull(user);
    }

    @Test
    public void userService_FindOne_ShouldReturnUser() {
        // Arrange
        Long id = 1L;
        String email = "mbruno@istat.it";

        when(userDao.findById(id)).thenReturn(Optional.of(new User(id, email)));

        // Act
        User user = userService.findOne(id);

        // Assert
        assertNotNull(user);
        assertEquals(id, user.getId());
        assertEquals(email, user.getEmail());
    }

    @Test
    public void userService_FindByEmail_ShouldReturnUser() {
        // Arrange
        Long id = 1L;
        String email = "mbruno@istat.it";

        when(userDao.findByEmail(email)).thenReturn(new User(id, email));

        // Act
        User user = userService.findByEmail(email);

        // Assert
        assertNotNull(user);
        assertEquals(id, user.getId());
        assertEquals(email, user.getEmail());
    }

    @Test
    public void userService_FindAll_ShouldReturnAllUsers() {
        // Arrange
        User user1 = new User(1L, "mbruno@istat.it");
        User user2 = new User(2L, "v.broeke@cbs.nl");
        List<User> testUsers = Arrays.asList(user1, user2);

        when(userDao.findAll()).thenReturn(testUsers);
        when(userRolesDao.findAll()).thenReturn(Arrays.asList());

        // Act
        List<User> users = userService.findAll();

        // Assert
        assertNotNull(users);
        assertEquals(2, users.size());
    }

    @Test
    public void userService_FindRoles_ShouldReturnAllRoles() {
        // Arrange
        UserRole role1 = new UserRole((short) 1);
        UserRole role2 = new UserRole((short) 2);
        List<UserRole> testRoles = Arrays.asList(role1, role2);

        when(userDao.findAll()).thenReturn(Arrays.asList());
        when(userRolesDao.findAll()).thenReturn(testRoles);

        // Act
        List<UserRole> roles = userService.findAllRoles();

        // Assert
        assertNotNull(roles);
        assertEquals(2, roles.size());
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