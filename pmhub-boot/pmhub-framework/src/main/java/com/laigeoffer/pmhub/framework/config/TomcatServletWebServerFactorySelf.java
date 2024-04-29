package com.laigeoffer.pmhub.framework.config;


import org.apache.catalina.*;
import org.apache.catalina.session.ManagerBase;
import org.apache.commons.logging.Log;
import org.apache.tomcat.util.ExceptionUtils;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.stereotype.Component;

import java.io.IOException;

/**
 * 由于启用了JWT，自定义TomcatServletWebServerFactory以禁用session，获取session时将返回null，避免开发时误用，同时略微提升性能
 */
@Component
public class TomcatServletWebServerFactorySelf extends TomcatServletWebServerFactory {

    @Override
    protected void postProcessContext(Context context) {
        super.postProcessContext(context);
        context.setManager(new NoSessionManager(logger));
    }

    public static class NoSessionManager extends ManagerBase implements Lifecycle {
        protected final Log logger;

        /**
         * 由于启用了jwt，因此禁用session，从代码中获取session将始终为null
         */
        public NoSessionManager(Log logger) {
            this.logger = logger;
        }

        @Override
        protected synchronized void startInternal() throws LifecycleException {
            super.startInternal();
            try {
                load();
            } catch (Throwable t) {
                ExceptionUtils.handleThrowable(t);
                this.logger.error("自定义SessionManager启动错误！", t);
            }
            setState(LifecycleState.STARTING);
        }

        @Override
        protected synchronized void stopInternal() throws LifecycleException {
            setState(LifecycleState.STOPPING);
            try {
                unload();
            } catch (Throwable t) {
                ExceptionUtils.handleThrowable(t);
                t.printStackTrace();
            }
            super.stopInternal();
        }

        @Override
        public void load() throws ClassNotFoundException, IOException {
            this.logger.warn("由于启用了JWT，HttpSession已经关闭。");
        }

        @Override
        public void unload() throws IOException {
        }

        @Override
        public Session createSession(String sessionId) {
            return null;
        }

        @Override
        public Session createEmptySession() {
            return null;
        }

        @Override
        public void add(Session session) {
        }

        @Override
        public Session findSession(String id) throws IOException {
            return null;
        }

        @Override
        public Session[] findSessions() {
            return null;
        }

        @Override
        public void processExpires() {
        }
    }
}
