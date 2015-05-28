package com.baymax;

import com.baymax.model.entity.AutoModel;
import com.baymax.model.entity.AutoSeries;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = BaymaxApplication.class)
@WebAppConfiguration
public class BaymaxApplicationTests {

    protected ObjectMapper mapper;

    @Autowired
    protected RequestMappingHandlerMapping handlerMapping;

    @Autowired
    protected RequestMappingHandlerAdapter handlerAdapter;

    @Before
    public void setUp() {
        mapper = new ObjectMapper();
    }

	@Test
	public void contextLoads() {
	}

    @Test
    public void testCreateAccountRequest() throws Exception {

        AutoModel autoModel = new AutoModel();
        autoModel.setModelName("Banking");

        AutoSeries autoSeries = new AutoSeries();
        autoSeries.setSeriesId((short)1);
        autoSeries.setSeriesName("A1");

        byte[] entityBytes = mapper.writeValueAsBytes(autoModel);

        MockHttpServletResponse postResponse = performPostRequest("/api/accounts/", entityBytes);
        Assert.assertNotNull(postResponse);
        String location = postResponse.getHeader("Location");
    }

    protected MockHttpServletResponse performPostRequest(String uri, byte[] content) throws Exception {
        MockHttpServletRequest request = new MockHttpServletRequest();
        MockHttpServletResponse response = new MockHttpServletResponse();

        request.setMethod("POST");
        request.setRequestURI(uri);
        request.setContentType("application/hal+json");
        request.setContent(content);

        Object handler = handlerMapping.getHandler(request).getHandler();
        handlerAdapter.handle(request, response, handler);
        Assert.assertEquals(response.getStatus(), HttpStatus.CREATED.value());
        return response;
    }

}
