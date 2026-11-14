package com.teacode.security;

import static org.assertj.core.api.Assertions.assertThat;

import jakarta.servlet.http.HttpServletResponse;
import org.junit.jupiter.api.Test;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;

class ForbiddenRequestLoggerTest {

    @Test
    void normalisesOriginsSoDefaultPortsCompareEqual() {
        assertThat(ForbiddenRequestLogger.origin("https://TeaCode.io/")).isEqualTo("https://teacode.io");
        assertThat(ForbiddenRequestLogger.origin("https://teacode.io:443")).isEqualTo("https://teacode.io");
        assertThat(ForbiddenRequestLogger.origin("http://localhost:8081/x")).isEqualTo("http://localhost:8081");
        assertThat(ForbiddenRequestLogger.origin("garbage")).isEmpty();
        assertThat(ForbiddenRequestLogger.origin(null)).isEmpty();
    }

    @Test
    void neverChangesTheResponseItObserves() throws Exception {
        var filter = new ForbiddenRequestLogger("https://teacode.io");
        var request = new MockHttpServletRequest("POST", "/api/v1/terminal/sessions");
        request.addHeader("Origin", "http://localhost:8081");
        var response = new MockHttpServletResponse();
        filter.doFilter(request, response, (req, res) -> ((HttpServletResponse) res).setStatus(403));
        assertThat(response.getStatus()).isEqualTo(403);

        var ok = new MockHttpServletResponse();
        filter.doFilter(new MockHttpServletRequest("GET", "/api/v1/problems"), ok, (req, res) -> ((HttpServletResponse) res).setStatus(200));
        assertThat(ok.getStatus()).isEqualTo(200);
    }
}
