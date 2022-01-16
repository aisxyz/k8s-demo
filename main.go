package main

import (
	"net/http"
	"os"
	"sync/atomic"
	"time"

	"github.com/gin-gonic/gin"
)

func main() {
	engin := gin.Default()

	var reqCnt uint32

	engin.GET("/name", func(c *gin.Context) {
		hn, err := os.Hostname()
		if err != nil {
			c.AbortWithStatus(http.StatusInternalServerError)
			return
		}
		c.JSON(http.StatusOK, gin.H{
			"Hostname": hn,
		})
	})

	engin.GET("/health", func(c *gin.Context) {
		start := time.Now()
		if cnt := atomic.AddUint32(&reqCnt, 1); cnt > 5 {
			// Used to test k8s probes only.
			c.AbortWithStatus(http.StatusInternalServerError)
		} else {
			c.JSON(http.StatusOK, gin.H{
				"At":      start,
				"Elapsed": time.Since(start).String(),
				"Count":   cnt,
			})
		}
	})

	engin.Run(":8080")
}
